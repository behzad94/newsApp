//
//  NetworkCall.swift
//  NewsApp
//
//  Created by DIAKO on 1/19/21.
//

import Foundation
import Alamofire
import RxSwift

class NetworkCall: NSObject {
    
    var parameters = Parameters()
    var headers = HTTPHeaders()
    var method: HTTPMethod!
    var urlComponent: NSURLComponents!
    var encoding: ParameterEncoding! = JSONEncoding.default
    
    init(parameters: [String:Any],urlComponent: NSURLComponents, method: HTTPMethod = .post, isJSONRequest: Bool = true) {
        super.init()
        parameters.forEach{self.parameters.updateValue($0.value, forKey: $0.key)}
        self.method = method
        
        if !isJSONRequest{
            encoding = URLEncoding.default
        }
        self.urlComponent = urlComponent
    }
    
    func executeCall<T: Codable>() -> Observable<RepositoryResponse<T>>  {
        return Observable.create({observer -> Disposable in
            
            AF.request(self.urlComponent.url!, method: self.method, parameters: self.parameters, encoding: self.encoding,interceptor: ApiHelper()).validate().responseDecodable(of: T.self) {
                response in
                debugPrint(response)
                if response.error == nil {
                    guard let data = response.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(T.self, from: data)
                        observer.onNext(RepositoryResponse(value: result, restDataResponse: response))
                        observer.onCompleted()
                    } catch {
                        print(error)
                    }
                } else {
                    guard let data = response.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(T.self, from: data)
                        observer.onNext(RepositoryResponse(value: result, restDataResponse: response))
                        observer.onCompleted()
                    } catch {
                        observer.onNext(RepositoryResponse(error: response.error))
                        observer.onError(response.error!)
                        print(error)
                    }
                }
            }
            return Disposables.create()
        })
    }
}

