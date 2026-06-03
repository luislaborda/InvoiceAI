import SwiftUI

struct OnboardingContainerView: View {
    @StateObject private var viewModel: OnboardingViewModel

    init(authService: AuthService, appState: AppState) {
        _viewModel = StateObject(wrappedValue: OnboardingViewModel(authService: authService, appState: appState))
    }

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.currentStep != .welcome {
                StepIndicator(
                    totalSteps: viewModel.totalSteps - 1,
                    currentStep: viewModel.currentStepIndex - 1
                )
                .padding(.top, 12)
                .padding(.horizontal, 24)
            }

            Group {
                switch viewModel.currentStep {
                case .welcome:
                    WelcomeView(onGetStarted: viewModel.advance)
                case .createAccount:
                    CreateAccountView(viewModel: viewModel)
                case .businessProfile:
                    BusinessProfileSetupView(viewModel: viewModel)
                case .taxSettings:
                    TaxSettingsSetupView(viewModel: viewModel)
                case .paymentTerms:
                    PaymentTermsSetupView(viewModel: viewModel)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.currentStep)
    }
}

private struct StepIndicator: View {
    let totalSteps: Int
    let currentStep: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalSteps, id: \.self) { index in
                Capsule()
                    .fill(index <= currentStep ? Color.blue : Color.gray.opacity(0.25))
                    .frame(height: 4)
            }
        }
    }
}

#Preview {
    OnboardingContainerView(authService: MockAuthService(), appState: AppState())
}
