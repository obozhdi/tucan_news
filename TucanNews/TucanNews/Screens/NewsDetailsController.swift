//
//  NewsDetailsController.swift
//  TucanNews
//
//  Created by Artem Pashkov on 22.01.2021.
//

import UIKit

final class NewsDetailsController: ViewController {
  
  private var object: (image: String, title: String, date: String, teaser: String, text: String)?
  
  private let backgroundImageView = CustomImageView()
  private let backgroundBlurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
  private let topBarBlurView = UIVisualEffectView(effect: nil)
  private let imageView = CustomImageView()
  private let titleLabel = UILabel()
  private let dateLabel = UILabel()
  private let textLabel = UILabel()
  
  private var shouldAnimateTopbarAppearance = true
  private var viewDidAppearOnScreen = false
  
  init(with object: (image: String, title: String, date: String, teaser: String, text: String)) {
    super.init(nibName: nil, bundle: nil)
    self.object = object
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    object = nil
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupSubviews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavbarOnShow()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    setupNavbarOnHide()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewDidAppearOnScreen = true
  }
  
}

private extension NewsDetailsController {
  
  private func setupNavbarOnShow() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.view.backgroundColor = .clear
    title = "Интересная Новость"
    
    navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
      title: "", style: .plain, target: nil, action: nil)
  }
  
  private func setupNavbarOnHide() {
    let navBar = self.navigationController?.navigationBar
    navBar?.barTintColor = UIColor.black
    navBar?.tintColor = UIColor.white
    navBar?.isTranslucent = false
    navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  }
  
  private func setupSubviews() {
    backgroundImageView.add(to: view).do {
      $0.edgesToSuperview()
      $0.contentMode = .scaleAspectFill
      $0.downloadImageFrom(urlString: object?.image ?? "", imageMode: .scaleAspectFill)
      $0.clipsToBounds = true
    }

    backgroundBlurView.add(to: view).do {
      $0.edgesToSuperview()
    }

    UIScrollView().add(to: view).do {
      $0.topToSuperview()
      $0.leftToSuperview(offset: 14)
      $0.rightToSuperview(offset: -14)
      $0.bottomToSuperview()
      $0.showsVerticalScrollIndicator = false
      $0.delegate = self

      UIView().add(to: $0).do {
        $0.edgesToSuperview()
        $0.width(Display.width - 28)

        imageView.add(to: $0).do {
          $0.leftToSuperview()
          $0.topToSuperview()
          $0.rightToSuperview()
          $0.height(190)
          $0.contentMode = .scaleAspectFill
          $0.clipsToBounds = true
          $0.layer.shadowColor = UIColor.black.cgColor
          $0.layer.shadowOpacity = 0.2
          $0.layer.shadowOffset = .zero
          $0.layer.shadowRadius = 4
          $0.downloadImageFrom(urlString: object?.image ?? "", imageMode: .scaleAspectFill)
        }

        titleLabel.add(to: $0).do {
          $0.topToBottom(of: imageView, offset: 14)
          $0.leftToSuperview()
          $0.rightToSuperview()
          $0.numberOfLines = 0
          $0.font = UIFont.systemFont(ofSize: 24, weight: .medium)
          $0.textColor = .white
          $0.text = object?.title
        }

        dateLabel.add(to: $0).do {
          $0.topToBottom(of: titleLabel, offset: 8)
          $0.leftToSuperview()
          $0.rightToSuperview()
          $0.numberOfLines = 1
          $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
          $0.textColor = UIColor.white.withAlphaComponent(0.4)
          $0.text = (object?.date ?? "Без даты").uppercased()
        }

        textLabel.add(to: $0).do {
          $0.topToBottom(of: dateLabel, offset: 8)
          $0.leftToSuperview()
          $0.rightToSuperview()
          $0.numberOfLines = 0
          $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
          $0.textColor = UIColor.white.withAlphaComponent(0.7)
          $0.bottomToSuperview(offset: -20)
          textLabel.text = object?.text
        }
      }
    }

    topBarBlurView.add(to: view).do {
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.height(Display.navbarSize)
    }
  }
  
  private func showTopBar() {
    if shouldAnimateTopbarAppearance && viewDidAppearOnScreen {
      UIView.animate(withDuration: 0.25) {
        self.shouldAnimateTopbarAppearance = false
        self.topBarBlurView.effect = UIBlurEffect(style: .dark)
        self.view.layoutIfNeeded()
      } completion: { completed in
        if completed {
          self.shouldAnimateTopbarAppearance = true
        }
      }
    }
  }
  
  private func hideTopBar() {
    if shouldAnimateTopbarAppearance && viewDidAppearOnScreen {
      UIView.animate(withDuration: 0.25) {
        self.shouldAnimateTopbarAppearance = false
        self.topBarBlurView.effect = nil
        self.view.layoutIfNeeded()
      } completion: { completed in
        if completed {
          self.shouldAnimateTopbarAppearance = true
        }
      }
    }
  }
  
}

extension NewsDetailsController: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    if offsetY > -64 { showTopBar() } else { hideTopBar() }
  }
  
}
