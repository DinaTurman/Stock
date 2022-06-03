//
//  FavoriteViewController.swift
//  Stocks
//
//  Created by Дина Турман on 03.06.2022.
//

import Foundation
import UIKit

class FavoriteViewController: UIViewController {
    weak var delegate: FavoriteViewControllerDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        
        return tableView
    }()
    
    private let presenter: FavoritePresenter
    
    init(presenter: FavoritePresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        presenter.loadView()
        
        
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Favorites"
    }
    

}
extension FavoriteViewController: FavoriteViewProtocol {
 
    func updateView() {
        presenter.favoriteStocks = delegate?.favoriteArray ?? []
        print("update FVC")
    }
    
    func updateView(withLoader isLoading: Bool) {
        print("Loader is - ", isLoading, " at ", Date())
    }
    
    func updateView(withError message: String) {
        print("Error - ", message)
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as! StockCell
        cell.configureStockCell(cellRowAt: indexPath.row)
        cell.configure(with: presenter.model(for: indexPath))
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.model(for: indexPath)
        let detailVC = ModuleBuilder.shared.detailVC(for: model)
        navigationController?.pushViewController(detailVC, animated: true)
        print(presenter.model(for: indexPath).isFavorite)
    }
}

protocol FavoriteViewControllerDelegate: AnyObject {
    var favoriteArray: [StockModelProtocol] { get }
}
