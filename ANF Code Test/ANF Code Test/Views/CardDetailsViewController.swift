//
//  CardDetailsViewController.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import UIKit
import Combine

final class CardDetailsViewController: UIViewController, Bindable {
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var topDescription: UILabel!
  @IBOutlet var promoMessage: UILabel!
  @IBOutlet var bottomDescription: UILabel!
  @IBOutlet var contentStack: UIStackView!
  
  var subscribers: Set<AnyCancellable> = []
  var viewModel: CardDetailsViewModel!
  
  func set(_ viewModel: CardDetailsViewModel) {
    self.viewModel = viewModel
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  private func configureUI() {
    if let image = UIImage(named: viewModel.imageName) {
      imageView.heightAnchor.constraint(equalToConstant: viewModel.calucualteHeightConstraint(size: image.size, newWidth: imageView.bounds.width)).isActive = true
    }
    imageView.image = UIImage(named: viewModel.imageName)
    titleLabel.text = viewModel.title
    topDescription.text = viewModel.topDescription
    promoMessage.text = viewModel.promoMessage
    bottomDescription.text = viewModel.bottomDescription
    configureButtons()
  }
  
  private func configureButtons() {
    viewModel.buttonList.forEach { content in
      let button = UIButton(type: .custom)
      contentStack.addArrangedSubview(button)
      button.setTitle(content.title, for: .normal)
      button.setTitleColor(.black, for: .normal)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
      button.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
      button.heightAnchor.constraint(equalToConstant: 60).isActive = true
      button.layer.borderWidth = 1
      button.addAction(UIAction(handler: { _ in
        guard let url = URL(string: content.target), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }), for: .touchUpInside)
    }
  }
}
