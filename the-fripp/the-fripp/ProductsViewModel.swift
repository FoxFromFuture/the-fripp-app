//
//  ProductsViewModel.swift
//  the-fripp
//
//  Created by Никита Лисунов on 10.12.2022.
//

import UIKit

final class ProductsViewModel {
    let productName: String
    let productAmount: String
    let pruductEndDate: Date
    var productStatusColor: UIColor
    
    init(
        productName: String,
        productAmount: String,
        pruductEndDate: Date
    ) {
        self.productName = productName
        self.productAmount = productAmount
        self.pruductEndDate = pruductEndDate
        self.productStatusColor = .black
    }
}
