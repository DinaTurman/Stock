//
//  DetailViewController.swift
//  Stocks
//
//  Created by Дина Турман on 27.05.2022.
//

import Foundation


import UIKit

class DetailViewController: UIViewController {
    private let presenter: DetailStockPresenterProtocol
    
    init(presenter: DetailStockPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.montserratBold(size: 28)
        label.text = "$3 204"
        
        return label
    }()
    
    private var dayDeltaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.montserratSemiBold(size: 12)
        label.text = "+$0.12 (1,15%)"
        label.textColor = UIColor.greenText()
        label.textAlignment = .center
        
        return label
    }()
    
    private var timelineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.isHidden = true
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubviews()
        presenter.loadView()
        
    }
    
    private func setupSubviews() {
        view.addSubview(priceLabel)
        view.addSubview(dayDeltaLabel)
        view.addSubview(timelineView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 162),
            
            dayDeltaLabel.centerXAnchor.constraint(equalTo: priceLabel.centerXAnchor),
            dayDeltaLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            
            timelineView.topAnchor.constraint(equalTo: dayDeltaLabel.bottomAnchor, constant: 20),
            timelineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timelineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timelineView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
            
        ])
    }
    
    private func setupView() {
        view.backgroundColor = .white
        self.navigationItem.setTitle(presenter.title, subtitle: presenter.subtitle)
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        dayDeltaLabel.text = presenter.change
        priceLabel.text = presenter.price
        
        setupFavoriteButton()
    }
    
    private func setupFavoriteButton() {

        let button = UIButton()
        button.setImage(UIImage(named: "Star 1"), for: .normal)
        button.setImage(UIImage(named: "Path (1)"), for: .selected)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.isSelected = presenter.favoriteButtonIsSelected
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    func configure(with model: StockModelProtocol) {
    
    }
    
    @objc func favoriteButtonTapped(sender: UIButton) {
        sender.isSelected.toggle()
        presenter.favoriteButtonTapped()
        sender.updateConfiguration()
    }
}
    
extension DetailViewController: DetailStockViewProtocol {
    func updateView() {
        timelineView.isHidden = false
    }
    
    func updateView(withLoader isLoading: Bool) {
        print("Loader is - ", isLoading, " at ", Date())
    }
    
    func updateView(withError message: String) {
        print("Error - ", message)
    }
}




