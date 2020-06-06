//
//  File.swift
//  
//
//  Created by FHRApps on 06.06.20.
//

import Foundation

public extension Date {
    init?(_ day: Int, _ month: Int, _ year: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) {
        let dateComponents = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        guard let date = Calendar.current.date(from: dateComponents) else {
            return nil
        }
        
        self = date
    }
}
