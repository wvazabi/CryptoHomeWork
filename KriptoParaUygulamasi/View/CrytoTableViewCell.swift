//
//  CrytoTableViewCell.swift
//  KriptoParaUygulamasi
//
//  Created by Enes Kaya on 21.10.2023.


import UIKit

class TableViewCell: UICollectionViewCell {
    let myCryptoCurrencyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let myCryptoPriceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    

    func setup(indexPath: IndexPath, cryptos: [Crypto]) {
        if let price = Double(cryptos[indexPath.row].price) {
            myCryptoPriceLabel.text = formatPrice(price)
            
            if price > 0.01 {
                myCryptoPriceLabel.textColor = .blue
            } else {
                myCryptoPriceLabel.textColor = .black
            }
        }
        
        myCryptoCurrencyLabel.text = cryptos[indexPath.row].currency

        myCryptoCurrencyLabel.backgroundColor = ["BTC", "ETH", "USDT"].contains(cryptos[indexPath.row].currency) ? .red : .green
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
    
    
    private func addView() {
        backgroundColor = .clear
        var refreshSpace: CGFloat = 10
        var height: CGFloat = 200
        addSubview(myCryptoPriceLabel)
        addSubview(myCryptoCurrencyLabel)

       
        myCryptoCurrencyLabel.topAnchor.constraint(equalTo: topAnchor, constant: refreshSpace).isActive = true
        myCryptoCurrencyLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        myCryptoCurrencyLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
        myCryptoCurrencyLabel.widthAnchor.constraint(equalToConstant: height).isActive = true

        myCryptoPriceLabel.topAnchor.constraint(equalTo: myCryptoCurrencyLabel.bottomAnchor, constant: refreshSpace).isActive = true
        myCryptoPriceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: refreshSpace).isActive = true
        myCryptoPriceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -refreshSpace).isActive = true
        myCryptoPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -refreshSpace).isActive = true
        myCryptoPriceLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

