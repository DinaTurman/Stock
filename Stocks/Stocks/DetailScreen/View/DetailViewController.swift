//
//  DetailViewController.swift
//  Stocks
//
//  Created by Дина Турман on 27.05.2022.
//

import Foundation


import UIKit

class DetailViewController: UIViewController{
    var symbol: String = ""
    var name: String = ""
    var id = ""
    
    private let presenter: DetailPresenterProtocol
    
    init(presenter: DetailPresenterProtocol) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.loadView(id: id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubviews()
        
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
        self.navigationItem.setTitle(symbol, subtitle: name)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Star 1"), style: .plain, target: self, action: nil)
    }
    
    func configure(with model: StockModelProtocol) {
        symbol = model.symbol
        name = model.name
        priceLabel.text = model.price
        dayDeltaLabel.text = model.change
        id = model.id
        print(id)
    }
}
    
extension DetailViewController: DetailViewProtocol {
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




