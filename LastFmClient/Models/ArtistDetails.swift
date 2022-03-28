struct ArtistDetailsResponse: Codable, Equatable {
    var artist: ArtistDetails
}

struct ArtistDetails: Codable, Equatable {
    var name: String
    var image: [ArtistImage]
    var stats: ArtistStats
    var similar: SimilarArtists
    var bio: ArtistBio
}

struct ArtistImage: Codable, Equatable {
    var imageUrl: String
    var size: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "#text"
        case size
    }
}

struct ArtistStats: Codable, Equatable {
    var listeners: String
    var playcount: String
}

struct SimilarArtists: Codable, Equatable {
    var artist: [SimilarArtist]
}

struct SimilarArtist: Codable, Equatable {
    var name: String
    var image: [ArtistImage]
}

struct ArtistBio: Codable, Equatable {
    var summary: String
}

