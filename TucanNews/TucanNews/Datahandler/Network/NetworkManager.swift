//
//  NetworkManager.swift
//  TucanNews
//
//  Created by Artem Pashkov on 22.01.2021.
//

import UIKit

protocol NetworkManagerDelegate: class {
  func didGetNews(news: [NewsObject])
}

class NetworkManager {
  
  weak var delegate: NetworkManagerDelegate?
  
  func getNews() {
    guard let remoteUrl = URL(string: "https://api.npoint.io/c2334a4ce879059ed673") else { return }
    let request = URLRequest(url: remoteUrl)
    
    URLSession.shared.dataTask(with: request) { data, resp, error in
      if let data = data {
        if let decodedResp = try? JSONDecoder().decode(NewsResponseObject.self, from: data) {
          DispatchQueue.main.async {
            self.delegate?.didGetNews(news: decodedResp.items)
          }
        }
      }
    }.resume()
  }
  
}
