//
//  LogoView.swift
//  Stocks
//
//  Created by Дина Турман on 24.05.2022.
//

import UIKit

final class StockCellLogoView: UIView {
    
  var symbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.montserratBold(size: 18)
        label.text = "YNDX"
        
        return label
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.montserratSemiBold(size: 12)
        label.text = "Yandex, LLC"
        
        return label
    }()
    
    private var favoritesButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "Path")
        button.setImage(image, for: .normal)
       
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(symbolLabel)
        addSubview(nameLabel)
        addSubview(favoritesButton)
        setupConstarints()
    }
    
    private func setupConstarints() {
        NSLayoutConstraint.activate([
            //Title Label
            symbolLabel.topAnchor.constraint(equalTo: topAnchor),
            symbolLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolLabel.heightAnchor.constraint(equalToConstant: 24),
            //Button
            favoritesButton.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 6),
            favoritesButton.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            favoritesButton.heightAnchor.constraint(equalToConstant: 16),
            favoritesButton.widthAnchor.constraint(equalToConstant: 16),
            //SubTitleLabel
            nameLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}


