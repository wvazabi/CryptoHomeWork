//
//  CrytoTableViewCell.swift
//  KriptoParaUygulamasi
//
//  Created by Enes Kaya on 21.10.2023.


import UIKit

class HomepageCell: UICollectionViewCell {
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func addView() {
        backgroundColor = .clear
        addSubview(priceLabel)
        addSubview(currencyLabel)

        // Apply constraints with meaningful constant values
        let padding: CGFloat = 10
        let labelHeight: CGFloat = 200
        currencyLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        currencyLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        currencyLabel.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
        currencyLabel.widthAnchor.constraint(equalToConstant: labelHeight).isActive = true

        priceLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: padding).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
    }

    func setup(indexPath: IndexPath, cryptos: [Crypto]) {
        if let price = Double(cryptos[indexPath.row].price) {
            priceLabel.text = formatPrice(price)
            
            if price > 0.01 {
                priceLabel.textColor = .blue
            } else {
                priceLabel.textColor = .black
            }
        }
        
        currencyLabel.text = cryptos[indexPath.row].currency

        currencyLabel.backgroundColor = ["BTC", "ETH", "USDT"].contains(cryptos[indexPath.row].currency) ? .red : .green
    }


    func formatPrice(_ price: Double) -> String {
        return String(format: "%.5f", price)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

