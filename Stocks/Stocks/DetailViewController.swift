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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.setTitle(symbol, subtitle: name)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Star 1"), style: .plain, target: self, action: nil)
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.addSubview(priceLabel)
        view.addSubview(dayDeltaLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 162),
            
            dayDeltaLabel.centerXAnchor.constraint(equalTo: priceLabel.centerXAnchor),
            dayDeltaLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8)
        ])
    }
    
    func configure(with stock: Stock) {
        symbol = stock.symbol
        name = stock.name
        priceLabel.text = "$" + String(format: "%.2f", stock.price)
        dayDeltaLabel.text = "$" + String(format: "%.2f", stock.change) + " " + "(\(String(format: "%.2f", stock.changePercentage))%)"
    }
}
    




