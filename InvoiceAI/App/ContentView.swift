import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: "mic.circle.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(.blue)

                Text("InvoiceAI")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Proposals and invoices\nby voice.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
