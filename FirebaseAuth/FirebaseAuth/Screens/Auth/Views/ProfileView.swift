import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        
        if let user = authViewModel.currentUser {
            List {
                Section {
                    HStack(spacing: 16){
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 70,height: 70)
                            .background(Color(.lightGray))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Text(user.email)
                                .font(.footnote)
                        }
                    }
                }//: - Profile Section
                
                Section("GENERAL") {
                    //SIGNOUT Button
                    Button {
                        authViewModel.signOut()
                    } label: {
                        Label {
                            Text("Sign Out")
                        } icon: {
                            Image(systemName: "arrow.left.circle.fill")
                                .foregroundStyle(.red)
                        }

                    }
                    
                    //Delete Button
                    Button {
                        Task {
                            await authViewModel.deleteAccount()
                        }
                    } label: {
                        Label {
                            Text("Delete Account")
                        } icon: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.red)
                        }

                    }

                }//: - Button Section
            }//: - List
        } else {
            ProgressView("Please View")
        }
        
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
