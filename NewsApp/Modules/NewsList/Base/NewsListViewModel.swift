//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by DIAKO on 1/20/21.
//

import Foundation
import RxSwift
import RxCocoa

class NewsListViewModel {
    
    let disposeBag = DisposeBag()
    let newsListResponse = PublishSubject<[News]>()
    var totalPage = "1"
    var nextPage = "1"
    var totlaNews = 0
    var category: String? = nil
    var isLoadMoreApiCall = true
    
    let onShowError = PublishSubject<String>()
    
    func newsList(page: String? = nil) {
        isLoadMoreApiCall = true
        let newsRepository = NewsRespository()
        newsRepository.newsList(category: category, page: page).subscribe(onNext: {
            [weak self] dataResponse in
            self?.isLoadMoreApiCall = false
            if dataResponse.error == nil {
                let statusCode = dataResponse.restDataResponse?.response?.statusCode
                if statusCode == 200 {
                    self?.totlaNews = dataResponse.value!.totalResults!
                    self?.newsListResponse.onNext(dataResponse.value!.articles!)
                } else {
                    self?.onShowError.onNext(dataResponse.value!.code ?? "Unknown error")
                }
            } else {
                self?.onShowError.onNext(dataResponse.value!.code ?? "Unknown error")
            }
        }).disposed(by: disposeBag)
    }
    
    func loadMoreNews(totalDisplayedNews: Int) {
        if !isLoadMoreApiCall {
            if totalDisplayedNews < totlaNews {
                let page = Int(nextPage)! + 1
                newsList(page: "\(page)")
            }
        }
    }
}
