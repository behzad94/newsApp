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
    
    func newsList(category: String? = nil, page: String? = nil) -> Observable<RepositoryResponse<NewsList>> {
        let apiHelper = ApiHelper.instance
        let urlComponent = apiHelper.apiURLComponentsInstance(path: "\(ApiHelper.TOP_HEADLINES_PATH)")
        let countryQuery = URLQueryItem(name: "country", value: "us")
        urlComponent.queryItems = [countryQuery]
        
        if let page = page {
            let pageQuery = URLQueryItem(name: "page", value: "\(page)")
            urlComponent.queryItems?.append(pageQuery)
        }
        
        if let category = category {
            let queryString = URLQueryItem(name: "category", value: category)
            urlComponent.queryItems?.append(queryString)
        }
        return NetworkCall(parameters:[:], urlComponent: urlComponent, method: .get, isJSONRequest: false).executeCall()
    }
}
