//
//  News.swift
//  NewsApp
//
//  Created by DIAKO on 1/20/21.
//

import Foundation

struct NewsList: Codable {
    let status: String?
    let totalResults: Int?
    let code: String?
    let message: String?
    let articles: [News]?
}

struct News: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
}

struct Source: Codable {
    let id: String?
    let name: String?
    
}
