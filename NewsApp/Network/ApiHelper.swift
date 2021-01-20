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
    
    var persistor = Persistor()
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
        let persistor = Persistor()
        if let token = persistor.getToken() {
            urlRequest.headers.add(.authorization(token))
        }
        completion(.success(urlRequest))
    }
    
//    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//
//        if let statusCode = request.response?.statusCode, statusCode == 401 {
//            
//            refreshToken { (success) in
//                if success {
//                    completion(.retry)
//                }
//            }
//        } else {
//            completion(.doNotRetry)
//            return
//        }
//
//    }
    
    // MARK: - Custom
//    func refreshToken(completion: @escaping (Bool) -> Void) {
//        let loginRepository = LoginRepository()
//        let persistor = Persistor()
//        loginRepository.login(userName: persistor.getUsername() ?? "", password: persistor.getPassword() ?? "", deviceInfo: DeviceInfo(fcmToken: pushKit)).subscribe(onNext: {
//            [weak self] dataResponse in
//            if dataResponse.error == nil {
//                let statusCode = dataResponse.restDataResponse?.response?.statusCode
//                if statusCode == 200 {
//                    completion(true)
//                } else {
//
//                }
//            } else {
//                //                    self?.onShowError.onNext("")
//            }
//
//        }).disposed(by: disposeBag)
//    }
}
