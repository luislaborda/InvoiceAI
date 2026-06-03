import Foundation
import SwiftUI

@MainActor
final class AppState: ObservableObject {
    @Published var hasCompletedOnboarding: Bool {
        didSet { UserDefaults.standard.set(hasCompletedOnboarding, forKey: Keys.hasCompletedOnboarding) }
    }
    @Published var currentUser: UserAccount? {
        didSet { persist(currentUser, forKey: Keys.currentUser) }
    }
    @Published var businessProfile: BusinessProfile? {
        didSet { persist(businessProfile, forKey: Keys.businessProfile) }
    }
    @Published var subscriptionStatus: SubscriptionStatus
    @Published var usageMeter: UsageMeter

    private enum Keys {
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
        static let currentUser = "currentUser"
        static let businessProfile = "businessProfile"
    }

    init() {
        self.hasCompletedOnboarding = UserDefaults.standard.bool(forKey: Keys.hasCompletedOnboarding)
        self.currentUser = Self.load(UserAccount.self, forKey: Keys.currentUser)
        self.businessProfile = Self.load(BusinessProfile.self, forKey: Keys.businessProfile)
        self.subscriptionStatus = .mockActive(plan: .starter)
        self.usageMeter = .forPlan(.starter)
    }

    func completeOnboarding() {
        hasCompletedOnboarding = true
    }

    func resetOnboarding() {
        hasCompletedOnboarding = false
        currentUser = nil
        businessProfile = nil
    }

    private func persist<T: Encodable>(_ value: T?, forKey key: String) {
        guard let value else {
            UserDefaults.standard.removeObject(forKey: key)
            return
        }
        if let data = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private static func load<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }
}
