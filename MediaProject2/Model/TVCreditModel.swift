//
//  TVCreditModel.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/02/01.
//

import Foundation

// MARK: - CreditModel
struct TVCreditModel: Codable {
    let cast: [Cast]?
    let id: Int?
}

// MARK: - Cast
struct Cast: Codable {
    let name: String?
    let profilePath: String?
    let character: String?
    let order: Int
    let department: Department?
    let job: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "none"
        self.profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)
        self.character = try container.decodeIfPresent(String.self, forKey: .character)
        self.order = try container.decodeIfPresent(Int.self, forKey: .order)!
        self.department = try container.decodeIfPresent(Department.self, forKey: .department)
        self.job = try container.decodeIfPresent(String.self, forKey: .job)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
        case character
        case order, department, job
    }
}

enum Department: String, Codable {
    case art = "Art"
    case costumeMakeUp = "Costume & Make-Up"
    case production = "Production"
    case sound = "Sound"
}
