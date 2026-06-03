import SwiftUI

struct FormField: View {
    let label: String
    @Binding var text: String
    var placeholder: String = ""
    var keyboard: UIKeyboardType = .default
    var isSecure: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.subheadline)
                .fontWeight(.medium)

            if isSecure {
                SecureField(placeholder, text: $text)
                    .padding()
                    .background(.gray.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboard)
                    .textInputAutocapitalization(keyboard == .emailAddress || keyboard == .URL ? .never : .words)
                    .autocorrectionDisabled(keyboard == .emailAddress || keyboard == .URL)
                    .padding()
                    .background(.gray.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        FormField(label: "Name", text: .constant(""), placeholder: "Mike Johnson")
        FormField(label: "Email", text: .constant(""), placeholder: "mike@example.com", keyboard: .emailAddress)
        FormField(label: "Password", text: .constant(""), placeholder: "Enter password", isSecure: true)
    }
    .padding()
}
