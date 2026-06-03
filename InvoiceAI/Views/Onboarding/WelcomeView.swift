import SwiftUI

struct WelcomeView: View {
    var onGetStarted: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Image(systemName: "mic.circle.fill")
                .font(.system(size: 100))
                .foregroundStyle(.blue)
                .padding(.bottom, 16)

            Text("InvoiceAI")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 8)

            Text("Proposals and invoices, by voice.")
                .font(.title3)
                .foregroundStyle(.secondary)
                .padding(.bottom, 40)

            VStack(alignment: .leading, spacing: 16) {
                FeatureRow(icon: "waveform", text: "Create proposals and invoices by voice")
                FeatureRow(icon: "eye", text: "Review everything before sending")
                FeatureRow(icon: "doc.richtext", text: "Generate professional PDFs")
                FeatureRow(icon: "archivebox", text: "Archive and find documents easily")
                FeatureRow(icon: "sparkles", text: "AI-powered with a paid plan")
            }
            .padding(.horizontal, 32)

            Spacer()

            Button(action: onGetStarted) {
                Text("Get Started")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
    }
}

private struct FeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.blue)
                .frame(width: 28, alignment: .center)
            Text(text)
                .font(.body)
        }
    }
}

#Preview {
    WelcomeView(onGetStarted: {})
}
