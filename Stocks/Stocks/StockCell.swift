//
//  StocksCell.swift
//  Stocks
//
//  Created by Дина Турман on 24.05.2022.
//

import UIKit

enum CellColors {
    case white, gray
}

final class StockCell: UITableViewCell {
    
    let logoView: StockCellLogoView = {
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
        let font = UIFont(name: "Montserrat-Bold", size: 18)
        label.font = font
        label.text = "$3 204"
        
        return label
    }()
    
    private var dayDeltaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont(name: "Montserrat-SemiBold", size: 12)
        label.font = font
        label.text = "+$0.12 (1,15%)"
        label.textColor = UIColor(red: 36/255, green: 178/255, blue: 93/255, alpha: 1)
        
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
            
            priceLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 188),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            priceLabel.heightAnchor.constraint(equalToConstant: 24),
            
            dayDeltaLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 178),
            dayDeltaLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            dayDeltaLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    private func changeBackground(color: CellColors) {
        switch color {
        case .white:
            contentView.backgroundColor = .white
        case .gray:
            contentView.backgroundColor = UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
        }
    }
    
    func configureStockCell(cellRowAt: Int) {
        cellRowAt % 2 == 1 ? changeBackground(color: .white) : changeBackground(color: .gray)
        contentView.layer.cornerRadius = 16
        //contentView.layer.cornerRadius = 25
        contentView.clipsToBounds = true
        
    }
}
