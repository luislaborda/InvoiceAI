import Foundation

struct JobLocation: Codable, Equatable {
    var address: String
    var latitude: Double?
    var longitude: Double?
    var notes: String?

    init(
        address: String,
        latitude: Double? = nil,
        longitude: Double? = nil,
        notes: String? = nil
    ) {
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.notes = notes
    }
}
