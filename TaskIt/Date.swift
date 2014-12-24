//
//  Date.swift
//  TaskIt
//
//  Created by Krzysztof Kula on 24/12/14.
//  Copyright (c) 2014 Krzysztof Kula. All rights reserved.
//

import Foundation

class Date {
    class func from(#year:Int, month:Int, day:Int ) -> NSDate {
        
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        var gregorianCalendar = NSCalendar(identifier: NSGregorianCalendar)
        var date = gregorianCalendar?.dateFromComponents(components)
        
        return date!
    }
}