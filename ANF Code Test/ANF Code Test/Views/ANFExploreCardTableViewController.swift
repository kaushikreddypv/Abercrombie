//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit
import Combine

final class ANFExploreCardTableViewController: UITableViewController, Bindable, Lodable {
  var loader: UIActivityIndicatorView?
  private(set) var viewModel: ANFExploreCardViewModel! = ANFExploreCardViewModel()
  var subscribers: Set<AnyCancellable> = []
  
  func set(_ viewModel: ANFExploreCardViewModel) {
    self.viewModel = viewModel
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubscribers()
    showLoader()
    viewModel.fetchProducts()
  }
  
  func setupSubscribers() {
    viewModel.$dataSource
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.dismissLoader()
        self?.tableView.reloadData()
      }
      .store(in: &subscribers)
    viewModel.$error
      .receive(on: DispatchQueue.main)
      .compactMap {$0}
      .sink { [weak self] _ in
      self?.dismissLoader()
        self?.showGenericError()
    }
    .store(in: &subscribers)
    NotificationCenter
               .Publisher(center: .default,
                          name: UIApplication.willEnterForegroundNotification)
               .sink { [weak self] _ in
                self?.viewModel?.fetchProducts()
               }
               .store(in: &subscribers)
  }
  
  private func showGenericError() {
    let alert = UIAlertController(title: "Error", message: "Something went wrong please try again later", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
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
