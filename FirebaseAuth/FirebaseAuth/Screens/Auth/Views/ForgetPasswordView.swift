import SwiftUI

struct ForgetPasswordView: View {
    
    @State private var email: String = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var isEmailSent: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Reset Password")
                    .font(.largeTitle)
                
                Text("Enter the email associated with your account and we will send an email with instructions to reset password")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.bottom, 32)
            
            InputView(placeHolder: "Enter your email", text: $email)
                .padding(.bottom, 16)
            Button {
                Task {
                    await authViewModel.forgetPassword(by: email)
                    
                    if !authViewModel.isError {
                        isEmailSent = true
                    }
                }
                
            } label: {
                Text("Send Instructions")
            }
            .buttonStyle(CapsuleButtonStyle())
            
            Spacer()
        }//: - Vstack
        .padding()
        .toolbarRole(.editor)
        .alert("Check your Inbox for instructions", isPresented: $isEmailSent) {
            Button("Ok") {
                dismiss()
            }
        }
        .onAppear {
            email = ""
        }
    }
}

#Preview {
    ForgetPasswordView()
}
