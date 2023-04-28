//
//  SearchCell.swift
//  the-fripp
//
//  Created by Никита Лисунов on 14.12.2022.
//

import UIKit

class SearchCell: UITableViewCell, UISearchBarDelegate {
    static let reuseIdentifier = "SearchCell"
    private let searchView = UISearchBar()
    
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
        setupSearchView()
        contentView.layer.backgroundColor = UIColor(hex: "CCEDFF").cgColor
        contentView.setHeight(to: 75)
    }
    
    private func setupSearchView() {
        contentView.addSubview(searchView)
        searchView.pin(to: contentView, [.left: -8, .right: -8, .bottom: 20, .top: 0])
        searchView.barTintColor = UIColor(hex: "CCEDFF")
        searchView.searchBarStyle = .minimal
        searchView.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        MainView.filteredData = []
        
        if searchText == "" {
            MainView.filteredData = MainView.productsViewModels
        } else {
            for product in MainView.productsViewModels {
                if product.productName.lowercased().contains(searchText.lowercased()) {
                    MainView.filteredData.append(product)
                }
            }
        }
        MainView.productsTable.reloadData()
    }
}
