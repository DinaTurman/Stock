//
//  LogoView.swift
//  Stocks
//
//  Created by Дина Турман on 24.05.2022.
//

import UIKit

final class StockCellLogoView: UIView {
    
    var favoriteAction: (() -> Void)?
    
    
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
    
   var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "Path")
        button.setImage(UIImage(named: "Path (1)"), for: .selected)
        button.addTarget(self, action: #selector(favoriteButtonTap), for: .touchUpInside)
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
        addSubview(favoriteButton)
        setupConstarints()
    }
    
    private func setupConstarints() {
        NSLayoutConstraint.activate([
            //Title Label
            symbolLabel.topAnchor.constraint(equalTo: topAnchor),
            symbolLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolLabel.heightAnchor.constraint(equalToConstant: 24),
            //Button
            favoriteButton.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 6),
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            favoriteButton.heightAnchor.constraint(equalToConstant: 16),
            favoriteButton.widthAnchor.constraint(equalToConstant: 16),
            //SubTitleLabel
            nameLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    @objc private func favoriteButtonTap() {
        favoriteButton.isSelected.toggle()
        favoriteAction?()
    }
}


