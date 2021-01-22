//
//  NewsListController.swift
//  TucanNews
//
//  Created by Artem Pashkov on 22.01.2021.
//

import UIKit

final class NewsListController: ViewController {
  
  private let tableView = UITableView()
  private var tableData: [NewsObject] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupSubviews()
    updateNewsList()
  }
  
  private func updateNewsList() {
    tableData = NetworkManager.getNews()
  }
  
}

private extension NewsListController {
  
  private func setupSubviews() {
    tableView.add(to: view).do {
      $0.edgesToSuperview()
      $0.delegate = self
      $0.dataSource = self
      
      $0.register(NewsListCell.self, forCellReuseIdentifier: NewsListCell.reuseIdentifier)
    }
  }
  
}

extension NewsListController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueCell(NewsListCell.self, withIdentifier: NewsListCell.reuseIdentifier, for: indexPath)
    cell.setData(with: tableData[indexPath.row])
    return cell
  }
  
}

final class NewsListCell: UITableViewCell {
  
  private let cellImageView = UIImageView()
  private let cellTitleLabel = UILabel()
  private let cellDateLabel = UILabel()
  private let cellTeaserLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupSubviews()
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  private func setupSubviews() {
    cellImageView.add(to: contentView).do {
      $0.leftToSuperview(offset: 16)
      $0.topToSuperview(offset: 8)
      $0.bottomToSuperview(offset: -8)
      $0.aspectRatio(1.0)
      $0.backgroundColor = .lightGray
    }
    
    cellTitleLabel.add(to: contentView).do {
      $0.leftToRight(of: cellImageView, offset: 16)
      $0.centerYToSuperview()
      $0.rightToSuperview(offset: -16)
    }
  }
  
  func setData(with object: NewsObject) {
    cellImageView.image = object.image
    cellTitleLabel.text = object.title
    cellDateLabel.text = String(describing: object.date)
    cellTeaserLabel.text = object.teaser
  }
  
}

