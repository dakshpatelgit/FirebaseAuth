import Foundation
import FirebaseAuth //Auth
import FirebaseFirestore //Storage

//MARK: - MAIN CLASS
@MainActor
final class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?  //firebase ka user
    @Published var currentUser: User? // apna wala user
    @Published var isError: Bool = false
    private let auth = Auth.auth()
    private let firestore = Firestore.firestore()
    
    init() {
        Task {
            await loadCurrentUser()
        }
    }
    
    //MARK: - LOAD CURRENT USER
    func loadCurrentUser() async {
        if let user = auth.currentUser {
            userSession = user
            await fetchUser(by: user.uid)
        }
    }
    
    
    //MARK: - LOGIN
    func login(email: String, password: String) async {
        do {
            let authResult = try await auth.signIn(withEmail: email, password: password)
            userSession = authResult.user
            await fetchUser(by: authResult.user.uid)
            print("Current User \(String(describing: currentUser))")
        } catch {
            isError = true
        }
    }
    
    //MARK: - SIGN UP
    func createUser(email: String, fullName: String, password: String) async {
        do {
            //creating user entry in auth
            let authResult = try await auth.createUser(withEmail: email, password: password)
            
            //storing extra detials of the user
            await storeUserInFirestore(uid: authResult.user.uid, email: email, fullName: fullName)
        } catch {
            isError = true
        }
    }
    
    //MARK: - STORES IN DATABASE
    func storeUserInFirestore(uid: String, email: String, fullName: String) async {
        let user = User(uid: uid, email: email, fullName: fullName)
        do {
            try firestore.collection("users").document(uid).setData(from: user)
        } catch {
            isError = true
        }
    }
    
    //MARK: - FETCHES USER FOR LOGIN
    func fetchUser(by uid: String) async {
        do {
            let document = try await firestore.collection("users").document(uid).getDocument()
            currentUser = try document.data(as: User.self)
        } catch {
            isError = true
        }
    }
    
    //MARK: - SIGNOUT
    func signOut() {
        do {
            userSession = nil
            currentUser = nil
            try auth.signOut()
        } catch {
            isError = true
        }
    }
    
    //MARK: - DELETE ACCOUNT
    func deleteAccount() async {
        do {
            userSession = nil
            currentUser = nil
            deleteUser(by: auth.currentUser?.uid ?? "") //Deletes User from DB
            try await auth.currentUser?.delete() //Deletes User from Auth
        } catch {
            isError = true
        }
    }
    
    //MARK: - DELETES USER FROM DB
    private func deleteUser(by uid: String){
        firestore.collection("users").document(uid).delete()
    }
    
    //MARK: - FORGET PASSWORD
    func forgetPassword(by email: String) async {
        do {
            try await auth.sendPasswordReset(withEmail: email)
        } catch {
            isError = true
        }
    }
    
}
