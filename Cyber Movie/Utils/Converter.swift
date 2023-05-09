//
//  Converter.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 09.05.2023.
//

import Foundation

func convertDate(date: String) -> String {
    guard let firstDashIndex = date.firstIndex(of: "-") else {
        return date
    }
    
    return String(date[..<firstDashIndex])
}
