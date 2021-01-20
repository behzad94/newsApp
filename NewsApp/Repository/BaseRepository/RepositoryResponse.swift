//
//  RepositoryResponse.swift
//  NewsApp
//
//  Created by DIAKO on 1/19/21.
//

import Foundation
import Alamofire

struct RepositoryResponse<Model> {
    
    var value: Model?
    var restDataResponse: DataResponse<Model, AFError>?
    var error: Error?
    
    init(value: Model? = nil, restDataResponse: DataResponse<Model, AFError>? = nil, error: Error? = nil) {
        self.value = value
        self.error = error
        self.restDataResponse = restDataResponse
    }
    func getStatus() -> Status {
        if error == nil {
            return Status.Success
        }
        return Status.Failure
    }
    
    enum Status {
        case Success
        case Failure
    }
}

