//
//  ProductsTableCell.swift
//  the-fripp
//
//  Created by Никита Лисунов on 10.12.2022.
//

import UIKit

final class ProductsTableCell: UITableViewCell {
    static let reuseIdentifier = "ProductsTableCell"
    private let mainView = UIView()
    private let productNameTextView = UILabel()
    private let productAmountTextView = UILabel()
    private let productEndDateTextView = UILabel()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        self.selectionStyle = .none
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupView() {
        setupMainView()
        contentView.layer.backgroundColor = UIColor(hex: "CCEDFF").cgColor
        contentView.setHeight(to: 75)
        setupProductNameTextView()
        setupProductAmountTextView()
        setupProductEndDateTextView()
    }
    
    private func setupMainView() {
        contentView.addSubview(mainView)
        mainView.pin(to: contentView, [.left: 0, .right: 0, .bottom: 5, .top: 5])
        mainView.backgroundColor = UIColor(hex: "DBF2FF")
        mainView.layer.cornerRadius = 10
        mainView.layer.borderWidth = 1.0
        mainView.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupProductNameTextView() {
//        productNameTextView.text = "Apples"
        productNameTextView.font = .systemFont(
            ofSize: 15,
            weight: .regular
        )
        productNameTextView.textColor = .black
        mainView.addSubview(productNameTextView)
        productNameTextView.pinTop(to: mainView.topAnchor, 0)
        productNameTextView.pin(to: mainView, [.left: 0, .right: 139])
        productNameTextView.pinBottom(to: mainView.bottomAnchor, 0)
        productNameTextView.textAlignment = .center
    }
    
    private func setupProductAmountTextView() {
//        productAmountTextView.text = "8"
        productAmountTextView.font = .systemFont(
            ofSize: 15,
            weight: .regular
        )
        productAmountTextView.textColor = .black
        mainView.addSubview(productAmountTextView)
        productAmountTextView.pinTop(to: mainView.topAnchor, 0)
        productAmountTextView.pin(to: mainView, [.left: 219, .right: 92])
        productAmountTextView.pinBottom(to: mainView.bottomAnchor, 0)
        productAmountTextView.textAlignment = .center
        productAmountTextView.layer.borderColor = UIColor.white.cgColor
        productAmountTextView.layer.borderWidth = 1.0
    }
    
    private func setupProductEndDateTextView() {
//        productEndDateTextView.text = "05.06.2022"
        productEndDateTextView.font = .systemFont(
            ofSize: 15,
            weight: .regular
        )
        productEndDateTextView.textColor = .black
        mainView.addSubview(productEndDateTextView)
        productEndDateTextView.pinTop(to: mainView.topAnchor, 0)
        productEndDateTextView.pin(to: mainView, [.left: 266, .right: 0])
        productEndDateTextView.pinBottom(to: mainView.bottomAnchor, 0)
        productEndDateTextView.textAlignment = .center
    }
    
    public func configure(newProduct: ProductsViewModel) {
        productNameTextView.text = newProduct.productName
        productAmountTextView.text = newProduct.productAmount
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"fi_FI")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
        let dateStr = dateFormatter.string(from: newProduct.pruductEndDate)
        productEndDateTextView.text = dateStr
        productEndDateTextView.textColor = newProduct.productStatusColor
    }
}
