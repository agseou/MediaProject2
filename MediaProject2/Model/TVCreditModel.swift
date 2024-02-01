//
//  TVCreditModel.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/02/01.
//

import Foundation

// MARK: - CreditModel
struct CreditModel: Codable {
    let cast, crew: [Cast]?
    let id: Int?
}

// MARK: - Cast
struct Cast: Codable {
    let name: String?
    let profilePath: String?
    let character: String?
    let order: Int?
    let department: Department?
    let job: String?

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
