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
    let newsListResponse = PublishSubject<NewsList>()
    
    let onShowError = PublishSubject<String>()
    
    func newsList() {
        let newsRepository = NewsRespository()
        newsRepository.newsList().subscribe(onNext: {
            [weak self] dataResponse in
            if dataResponse.error == nil {
                let statusCode = dataResponse.restDataResponse?.response?.statusCode
                if statusCode == 200 {
                    self?.newsListResponse.onNext(dataResponse.value!)
                } else {
                    self?.onShowError.onNext("Unknown error")
                }
            } else {
                self?.onShowError.onNext( "Unknown error")
            }
        }).disposed(by: disposeBag)
    }
}
