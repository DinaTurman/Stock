//
//  UINavigationItem+ Ext.swift
//  Stocks
//
//  Created by Дина Турман on 27.05.2022.
//

import UIKit

extension UINavigationItem {

    func setTitle(_ title: String, subtitle: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.montserratBold(size: 18)
        titleLabel.textColor = .black

        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.montserratSemiBold(size: 12)
        subtitleLabel.textColor = .gray

        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.axis = .vertical

        self.titleView = stackView
    }
}
