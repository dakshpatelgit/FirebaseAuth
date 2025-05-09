import SwiftUI


struct CreateAccountView: View {
    //MARK: - PROPERTIES
    @State private var email: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Please complete all information to create an account.")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.vertical)
            
            InputView(placeHolder: "Email or Phone Number", text: $email)
            InputView(placeHolder: "Full Name", text: $fullName)
            InputView(placeHolder: "Passowrd", isSecureField: true, text: $password)
            
            
            ZStack(alignment: .trailing) {
                InputView(placeHolder: "Confirm Passowrd", isSecureField: true, text: $confirmPassword)
                
                Spacer()
                
                if !password.isEmpty && !confirmPassword.isEmpty {
                    Image(systemName: "\(isValidPassword ? "checkmark.circle.fill" : "xmark.circle.fill")")
                        .imageScale(.large)
                        .fontWeight(.bold)
                        .foregroundStyle(isValidPassword ? Color(.green) : Color(.red))
                    
                }
            }
            
            Spacer()
            
            Button {
                Task {
                    await authViewModel.createUser(email: email,
                                                   fullName: fullName,
                                                   password: password)
                    
                    if !authViewModel.isError {
                        dismiss()
                    }
                }
            } label: {
                Text("Create Account")
            }
            .buttonStyle(CapsuleButtonStyle())
        }
        .navigationTitle("Set up your Account")
        .toolbarRole(.editor)
        .padding()
    }
    var isValidPassword: Bool {
        password == confirmPassword
    }
}

//MARK: - PREVIEWS
#Preview {
    CreateAccountView()
        .environmentObject(AuthViewModel())
}
