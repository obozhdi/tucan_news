//
//  NewsDetailsController.swift
//  TucanNews
//
//  Created by Artem Pashkov on 22.01.2021.
//

import UIKit

final class NewsDetailsController: ViewController {
  
  private var newsObject: NewsObject?
  
  init(with newsObject: NewsObject) {
    super.init(nibName: nil, bundle: nil)
    self.newsObject = newsObject
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    newsObject = nil
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupSubviews()
  }
  
}

private extension NewsDetailsController {
  
  private func setupSubviews() {
    view.backgroundColor = .red
  }
  
}
