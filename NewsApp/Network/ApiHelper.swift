//
//  ApiHelper.swift
//  NewsApp
//
//  Created by DIAKO on 1/19/21.
//

import Foundation
import Alamofire
import RxSwift

class ApiHelper {
    
    //api's paths
    public static let TOP_HEADLINES_PATH = "top-headlines"
    
    let disposeBag = DisposeBag()
    
    static let instance:ApiHelper = {
        let instance = ApiHelper()
        return instance
    }()
    
    private var session: Session!
    
    init() {
        let config = Session.default.session.configuration
        session = Session(configuration: config, interceptor: self)
    }
    
    
    func apiURLComponentsInstance(path:String? = nil) -> NSURLComponents {
        let urlComponents = NSURLComponents()
        urlComponents.scheme = Bundle.main.infoDictionary!["API_SCHEME"] as? String
        urlComponents.host = Bundle.main.infoDictionary!["API_HOST"] as? String
        urlComponents.port = NSNumber(value: Int(Bundle.main.infoDictionary!["API_PORT"] as! String)!)
        urlComponents.path = "/v\(Bundle.main.infoDictionary!["API_VERSION"] as! String)" + "/\(path!)"
        return urlComponents
    }
}

extension ApiHelper: RequestInterceptor, RequestRetrier {
    typealias AdapterResult = Swift.Result<URLRequest, Error>
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Swift.Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.timeoutInterval = 60.0
        let apiToken = HTTPHeader(name: "x-api-key", value: "\(ApiToken)")
        urlRequest.headers.add(apiToken)
        completion(.success(urlRequest))
    }
}
