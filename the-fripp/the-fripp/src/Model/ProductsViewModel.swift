//
//  ProductsViewModel.swift
//  the-fripp
//
//  Created by Никита Лисунов on 10.12.2022.
//

import UIKit

final class ProductsViewModel {
    let productID: Int
    let productName: String
    let productBestBeforeDate: Date
    let productQuantity: Int
    var productStatusColor: UIColor
    
    init(
        productID: Int,
        productName: String,
        productBestBeforeDate: Date,
        productQuantity: Int
    ) {
        self.productID = productID
        self.productName = productName
        self.productBestBeforeDate = productBestBeforeDate
        self.productQuantity = productQuantity
        self.productStatusColor = .black
    }
}
