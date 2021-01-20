//
//  BaseModel.swift
//  NewsApp
//
//  Created by DIAKO on 1/20/21.
//

import Foundation

// MARK: - Generic base model for all service request
struct BaseModel<T: Codable>: Codable {
    let status: String?
    let totalResults: Int?
    let code: String?
    let message: String?
    let result: T?
    let body: T?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decodeIfPresent(String.self, forKey: .status)
        totalResults = try? values.decodeIfPresent(Int.self, forKey: .totalResults)
        code = try? values.decodeIfPresent(String.self, forKey: .code)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
        result = try? values.decodeIfPresent(T.self, forKey: .result)
        body = try? values.decodeIfPresent(T.self, forKey: .body)
    }
}

// MARK: - Error
struct ErrorType: Codable {
    let code: Int?
    let errorDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case errorDescription = "Description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try? values.decode(Int.self, forKey: .code)
        errorDescription = try? values.decode(String.self, forKey: .errorDescription)
    }
}
