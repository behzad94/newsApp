//
//  NewsRepository.swift
//  NewsApp
//
//  Created by DIAKO on 1/20/21.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa


class NewsRespository {
    
    let newsRestRepository = NewsRestRespository()
    
    func newsList(category: String? = nil, page: String? = nil) -> Observable<RepositoryResponse<NewsList>> {
        return newsRestRepository.newsList(category: category, page: page)
    }
}
