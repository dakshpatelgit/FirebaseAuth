import SwiftUI

struct LoginView: View {
    //MARK: - PROPERTIES
    
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing: 16) {
                    //MARK: - logo
                    Image("login")
                        .resizable()
                        .scaledToFit()
                    
                    //title
                    Text("Lets connect with us!")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Spacer().frame(height: 12)
                    
                    //MARK: - textfield
                    InputView(placeHolder: "Email or Phone Number", text: $email)
                    InputView(placeHolder: "Password", isSecureField: true, text: $password)
                    
                    //MARK: - forget password
                    HStack {
                        Spacer()
                        
                        NavigationLink {
                            ForgetPasswordView()
                                .environmentObject(authViewModel)
                        } label: {
                            (Text("Forget Password?")
                                .foregroundStyle(.gray)
                                .font(.subheadline)
                                .fontWeight(.medium))
                        }
                    }//: - Hstack
                    
                    
                    
                    //MARK: - login button
                    Button {
                        Task {
                            await authViewModel.login(email: email, password: password)
                        }
                    } label: {
                        Text("Login")
                    }
                    .buttonStyle(CapsuleButtonStyle())
                    Spacer()
                    
                    //MARK: - bottom view or
                    HStack(spacing: 16) {
                        line
                        Text("or")
                            .fontWeight(.semibold)
                        line
                    }
                    .foregroundStyle(.gray)
                    
                    //MARK: - apple
                    Button {
                        
                    } label: {
                        Label("Sign up with Apple", systemImage: "apple.logo")
                    }
                    .buttonStyle(CapsuleButtonStyle(bgColor: .black))
                    
                    //MARK: - google
                    Button {
                        
                    } label: {
                        HStack {
                            Image("google")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text("Sign up with Google")
                        }
                    }
                    .buttonStyle(CapsuleButtonStyle(textColor: .black, bgColor: .clear, hasBorder: true))
                    
                    
                    //MARK: - footer
                    NavigationLink {
                        CreateAccountView()
                            .environmentObject(authViewModel)
                    }
                    label: {
                        HStack {
                            Text("Don't have an account?")
                                .foregroundStyle(.black)
                            Text("Sign Up")
                                .foregroundStyle(.teal)
                        }
                        .fontWeight(.medium)
                    }
                    
                    
                }//: - VSTACK
            }//: - ScrollView
        }//: - Main Nstack
        .ignoresSafeArea()
        .padding(.horizontal)
        .padding(.vertical, 8)
        .alert("Something went wrong", isPresented: $authViewModel.isError){}
    }
    
    private var line: some View {
        VStack { Divider().frame(height: 1)}
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}

