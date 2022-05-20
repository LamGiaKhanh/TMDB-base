// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let movieListResponse = try? newJSONDecoder().decode(MovieListResponse.self, from: jsonData)

import Foundation

// MARK: - MovieListResponse
public struct MovieListResponse: Codable {
    public let dates: Dates
    public let page: Int
    public let movies: [Movie]
    public let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        dates = try values.decodeIfPresent(Dates.self, forKey: .dates) ?? Dates(maximum: "", minimum: "")
        page = try values.decodeIfPresent(Int.self, forKey: .page) ?? 0
        movies = try values.decodeIfPresent([Movie].self, forKey: .movies) ?? []
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages) ?? 0
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults) ?? 0
    }
}

// MARK: - Dates
public struct Dates: Codable {
    public let maximum, minimum: String
}

// MARK: - Result
public struct Movie: Codable, Identifiable {
    
    public var adult: Bool
    public var backdropPath: String
    public var genreIDS: [Int]
    public var id: Int
    public var originalLanguage: String
    public var originalTitle, overview: String
    public var popularity: Double
    public var posterPath, releaseDate, title: String
    public var video: Bool
    public var voteAverage: Double
    public var voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        adult = try values.decodeIfPresent(Bool.self, forKey: .adult) ?? false
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
        genreIDS = try values.decodeIfPresent([Int].self, forKey: .genreIDS) ?? []
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage) ?? ""
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle) ?? ""
        overview = try values.decodeIfPresent(String.self, forKey: .overview) ?? ""
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity) ?? 0
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        video = try values.decodeIfPresent(Bool.self, forKey: .video) ?? false
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
    }
    
    public init(adult: Bool = false, backdropPath: String = "https://i.pinimg.com/originals/89/5d/24/895d2482fd516e809023ef09d599769f.jpg", genreIDS: [Int] = [], id: Int = 0, originalLanguage: String = "Vietnamese", originalTitle: String = "Mocked movie", overview: String = "bla bla", popularity: Double = Double(Int.random(in: 1..<10)), posterPath: String = "https://i.pinimg.com/originals/89/5d/24/895d2482fd516e809023ef09d599769f.jpg", releaseDate: String = "", title: String = "", video: Bool = false, voteAverage: Double = 0, voteCount: Int = 1000) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

public enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case fr = "fr"
}
