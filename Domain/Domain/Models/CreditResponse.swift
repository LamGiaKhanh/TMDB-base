//
//  CreditResponse.swift
//  Domain
//
//  Created by ExecutionLab's Macbook on 24/05/2022.
//

import Foundation

// MARK: - CreditResponse
public struct CreditResponse: Codable {
    public let id: Int
    public let cast, crew: [Cast]
}

// MARK: - Cast
public struct Cast: Codable, Identifiable {
    public let adult: Bool
    public let gender, id: Int
    public let knownForDepartment: String
    public let name, originalName: String
    public let popularity: Double
    public let profilePath: String
    public let castID: Int
    public let character: String
    public let creditID: String
    public let order: Int
    public let department: String
    public let job: String

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        adult = try values.decodeIfPresent(Bool.self, forKey: .adult) ?? false
        gender = try values.decodeIfPresent(Int.self, forKey: .gender) ?? 0
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        knownForDepartment = try values.decodeIfPresent(String.self, forKey: .knownForDepartment) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        originalName = try values.decodeIfPresent(String.self, forKey: .originalName) ?? ""
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity) ?? 0
        profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath) ?? ""
        castID = try values.decodeIfPresent(Int.self, forKey: .castID) ?? 0
        character = try values.decodeIfPresent(String.self, forKey: .character) ?? ""
        creditID = try values.decodeIfPresent(String.self, forKey: .creditID) ?? ""
        order = try values.decodeIfPresent(Int.self, forKey: .order) ?? 0
        department = try values.decodeIfPresent(String.self, forKey: .department) ?? ""
        job = try values.decodeIfPresent(String.self, forKey: .job) ?? ""
    }
}
