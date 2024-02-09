//
//  DateConverter.swift
//  maprozorskiyPW2
//
//  Created by Михаил Прозорский on 08.02.2024.
//

import UIKit

extension Date {
    var convertedDate: Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: self)
        
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd" as String
        let sourceDate = dateFormatter.date(from: formattedDate as String)
        return sourceDate ?? Date()
    }
    
    var shortDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        let formattedDate = formatter.string(from: self)
        return formattedDate
    }
}
