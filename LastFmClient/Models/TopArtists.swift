struct TopArtistsResponse: Codable, Equatable {
    var topArtists: TopArtists
    
    enum CodingKeys: String, CodingKey {
        case topArtists = "topartists"
    }
}

struct TopArtists: Codable, Equatable {
    var artist: [TopArtist]
    var meta: TopArtistsMetaData
    
    enum CodingKeys: String, CodingKey {
        case artist
        case meta = "@attr"
    }
}

struct TopArtist: Codable, Equatable {
    var name: String
    var listeners: String
    var image: [ArtistImage]
}

struct TopArtistsMetaData: Codable, Equatable {
    var country: String
    var page: String
    var perPage: String
    var totalPages: String
    var total: String
}
