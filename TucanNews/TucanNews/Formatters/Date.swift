//
//  Date.swift
//  TucanNews
//
//  Created by Artem Pashkov on 23.01.2021.
//

import UIKit

class Day {
  
  class func formatDate(date: Date?) -> String {
    guard let date = date else { return "Без даты" }
    
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .long
    
    formatter.string(from: date)
    // July 15, 2019 at 9:41:00 AM PST
    
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    
    return formatter.string(from: date)
  }
 
}
