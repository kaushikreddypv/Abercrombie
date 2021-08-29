//
//  ExploreCardTableViewCell.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/26/21.
//

import UIKit
import Combine

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
  
  private func configureUI() {
    title?.text = viewModel?.title
    productImage?.image = UIImage(named: viewModel?.imageName ?? "")
  }
}
