//
//  NetworkManager.swift
//  TucanNews
//
//  Created by Artem Pashkov on 22.01.2021.
//

import UIKit

class NetworkManager {
  
  class func getNews() -> [NewsObject] {
    var news: [NewsObject] = []
    
    for index in 0...4 {
      news.append(NewsObject(image: tucans[index] ?? UIImage(),
                             date: Date(),
                             title: titles[index],
                             teaser: teasers[index],
                             text: texts[index]))
    }
    
    return news
  }
  
}
