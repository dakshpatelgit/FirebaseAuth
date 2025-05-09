import SwiftUI

struct EmailSentView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: "envelope.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(.teal)
            
            VStack(spacing: 8) {
                Text("Check your email")
                    .font(.largeTitle.bold())
                Text("We have sent a password recover instructions to your email")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }
            Button {
                dismiss()
            } label: {
                Text("Skip, I'll confirm later")
            }
            .buttonStyle(CapsuleButtonStyle())
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                (Text("Did not receive the email? Check your spam filter, or ")
                    .foregroundStyle(.black)
                 +
                 Text("Try another email address")
                    .foregroundStyle(.teal)
                )
            }
        }//:- Main Vstack
        .padding()
        .toolbarRole(.editor)
    }
}

#Preview {
    EmailSentView()
}
