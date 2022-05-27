//
//  LogoView.swift
//  Stocks
//
//  Created by Дина Турман on 24.05.2022.
//

import UIKit

final class StockCellLogoView: UIView {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.montserratBold(size: 18)
        label.text = "YNDX"
        
        return label
    }()
    
    private var subTitleLabel: UILabel = {
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
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(favoritesButton)
        setupConstarints()
    }
    
    private func setupConstarints() {
        NSLayoutConstraint.activate([
            //Title Label
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            //Button
            favoritesButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 6),
            favoritesButton.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            favoritesButton.heightAnchor.constraint(equalToConstant: 16),
            favoritesButton.widthAnchor.constraint(equalToConstant: 16),
            //SubTitleLabel
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            subTitleLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}


