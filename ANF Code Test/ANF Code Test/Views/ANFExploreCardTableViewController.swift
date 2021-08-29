//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit
import Combine

final class ANFExploreCardTableViewController: UITableViewController, Bindable {
  
  private(set) var viewModel: ANFExploreCardViewModel! = ANFExploreCardViewModel()
  var subscribers: Set<AnyCancellable> = []
  
  func set(_ viewModel: ANFExploreCardViewModel) {
    self.viewModel = viewModel
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubscribers()
    viewModel.fetchProducts()
  }
  
  func setupSubscribers() {
    viewModel.$dataSource
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.tableView.reloadData()
      }
      .store(in: &subscribers)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.dataSource.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = self.tableView.dequeueReusableCell(withIdentifier: ExploreCardTableViewCell.identifier, for: indexPath) as? ExploreCardTableViewCell, let cellModel = viewModel.dataSource[safe: indexPath.row] else {
      return UITableViewCell()
    }
    
    cell.set(cellModel)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: Segues.cardDetails.rawValue, sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let vc = segue.destination as? CardDetailsViewController,
          let index = tableView.indexPathForSelectedRow?.row,
          let cardVM = viewModel.getCardDetailViewModel(index) else {
      return
    }
    vc.set(cardVM)
  }
  
  @IBAction func unwindSegueFromCardDetails(_ segue: UIStoryboardSegue) {
    
  }
}
