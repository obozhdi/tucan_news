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
      $0.separatorStyle = .none
      
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = NewsDetailsController(with: tableData[indexPath.row])
    navigationController?.pushViewController(vc)
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
    contentView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
    backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
    
    UIView().add(to: contentView).do {
      $0.leftToSuperview(offset: 14)
      $0.rightToSuperview(offset: -14)
      $0.bottomToSuperview(offset: -14)
      $0.topToSuperview(offset: 14)
      $0.backgroundColor = .white
      $0.layer.shadowColor = UIColor.black.cgColor
      $0.layer.shadowOpacity = 0.2
      $0.layer.shadowOffset = .zero
      $0.layer.shadowRadius = 4

      
      cellImageView.add(to: $0).do {
        $0.leftToSuperview()
        $0.topToSuperview()
        $0.rightToSuperview()
        $0.height(190)
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
      }
      
      cellTitleLabel.add(to: $0).do {
        $0.topToBottom(of: cellImageView, offset: 14)
        $0.leftToSuperview(offset: 20)
        $0.rightToSuperview(offset: -20)
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        $0.textColor = .black
      }
      
      cellDateLabel.add(to: $0).do {
        $0.topToBottom(of: cellTitleLabel, offset: 8)
        $0.leftToSuperview(offset: 20)
        $0.rightToSuperview(offset: -20)
        $0.numberOfLines = 1
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = UIColor.black.withAlphaComponent(0.4)
      }
      
      cellTeaserLabel.add(to: $0).do {
        $0.topToBottom(of: cellDateLabel, offset: 8)
        $0.leftToSuperview(offset: 20)
        $0.rightToSuperview(offset: -20)
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = UIColor.black.withAlphaComponent(0.7)
        $0.bottomToSuperview(offset: -20)
      }
    }
  }
  
  func setData(with object: NewsObject) {
    cellImageView.image = object.image
    cellTitleLabel.text = object.title
    cellDateLabel.text = String(describing: object.date).uppercased()
    cellTeaserLabel.text = object.teaser
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) { selectionStyle = .none }
  
}

