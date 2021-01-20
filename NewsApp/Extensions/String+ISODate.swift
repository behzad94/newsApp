//
//  Date+ISO.swift
//  NewsApp
//
//  Created by DIAKO on 1/21/21.
//

import Foundation

extension String {
    func isoDateToDate() -> String {
        let dateFormatter = DateFormatter()
//        2021-01-20T14:01:45Z
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:self)!
        dateFormatter.dateFormat = "d MMM YYYY"
        let displayDate = dateFormatter.string(from: date)
        return displayDate
    }
}
