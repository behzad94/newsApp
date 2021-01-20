//
//  NewsRestRespository.swift
//  NewsApp
//
//  Created by DIAKO on 1/20/21.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa


class NewsRestRespository {
    
    func newsList(category: String? = nil) -> Observable<RepositoryResponse<NewsList>> {
        let apiHelper = ApiHelper.instance
        let urlComponent = apiHelper.apiURLComponentsInstance(path: "\(ApiHelper.TOP_HEADLINES_PATH)")
        let countryQuery = URLQueryItem(name: "country", value: "us")
        urlComponent.queryItems = [countryQuery]
        if let category = category {
        let queryString = URLQueryItem(name: "category", value: category)
            urlComponent.queryItems = [queryString]
        }
        return NetworkCall(parameters:[:], urlComponent: urlComponent, method: .get, isJSONRequest: false).executeCall()
    }
}
