//
//  ExploreCardTableViewCellTests.swift
//  ANF Code TestTests
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import UIKit

protocol Lodable: AnyObject {
  var loader: UIActivityIndicatorView? { get set }
  func showLoader()
  func dismissLoader()
}

extension Lodable where Self: UIViewController {
  func showLoader() {
    var acivityIndicator = UIActivityIndicatorView(style: .large)
    if let loader = loader {
      acivityIndicator = loader
    } else {
      acivityIndicator.color = .darkGray
      acivityIndicator.center = view.center
      acivityIndicator.hidesWhenStopped = true
      loader = acivityIndicator
      loader?.accessibilityIdentifier = "spinner"
      view.addSubview(acivityIndicator)
    }
    disableInteractions(true)
    acivityIndicator.startAnimating()
  }
  
  func dismissLoader() {
    loader?.stopAnimating()
    disableInteractions(false)
  }
  
  func disableInteractions(_ isDisable: Bool) {
    view.isUserInteractionEnabled = !isDisable
    navigationController?.navigationBar.isUserInteractionEnabled = !isDisable
  }
}
