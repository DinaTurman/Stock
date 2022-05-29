//
//  StocksCell.swift
//  Stocks
//
//  Created by Дина Турман on 24.05.2022.
//

import UIKit

enum CellColors {
    case white, gray
    
    var cellColor: UIColor {
        switch self {
        case .white:
            return .white
        case .gray:
            return UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
        }
    }
}

final class StockCell: UITableViewCell {
    
    private let logoView: StockCellLogoView = {
        let view = StockCellLogoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var iconView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .systemPink
        image.image = UIImage(named: "Logo")
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        
        
        return image
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.montserratBold(size: 18)
        label.text = "$3 204"
        return label
    }()
    
    private var dayDeltaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.montserratSemiBold(size: 12)
        label.text = "+$0.12 (1,15%)"
        label.textColor = UIColor.greenText()
        label.textAlignment = .left
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(iconView)
        contentView.addSubview(logoView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(dayDeltaLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            iconView.heightAnchor.constraint(equalToConstant: 52),
            iconView.widthAnchor.constraint(equalToConstant: 52),
            
            logoView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            logoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            logoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 14),
            
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            priceLabel.heightAnchor.constraint(equalToConstant: 24),
            
            dayDeltaLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            dayDeltaLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            dayDeltaLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    private func changeBackground(color: CellColors) {
        contentView.backgroundColor = color.cellColor
    }
    
    func configureStockCell(cellRowAt: Int) {
        cellRowAt % 2 == 1 ? changeBackground(color: .white) : changeBackground(color: .gray)
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.borderWidth = 4
        contentView.layer.masksToBounds = true
    }
    
    func configure(with model: StockModelProtocol) {
        logoView.symbolLabel.text = model.symbol
        logoView.nameLabel.text = model.name
        priceLabel.text = model.price
        dayDeltaLabel.text = model.change
           
       }
}
