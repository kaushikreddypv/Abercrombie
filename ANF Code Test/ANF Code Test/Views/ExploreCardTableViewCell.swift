//
//  ExploreCardTableViewCell.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/26/21.
//

import UIKit
import Combine
import AlamofireImage

final class ExploreCardTableViewCell: UITableViewCell, Bindable {
  static let identifier = "exploreContentCell"
  
  @IBOutlet var title: UILabel!
  @IBOutlet var productImage: UIImageView!
  
  private(set) var viewModel: ExploreCardCellModel!
  private(set) var subscribers: Set<AnyCancellable> = []
  
  func set(_ viewModel: ExploreCardCellModel) {
    self.viewModel = viewModel
    configureUI()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    productImage?.af.cancelImageRequest()
  }
  
  private func configureUI() {
    title?.text = viewModel?.title
    guard let url = URL(string: viewModel.imageName), viewModel.imageName.hasPrefix("http") else {
      productImage?.image = UIImage(named: viewModel.imageName)
      return
    }
    productImage?.af.setImage(withURL: url)
  }
}
