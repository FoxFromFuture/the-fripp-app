//
//  MainController.swift
//  the-fripp
//
//  Created by Никита Лисунов on 21.04.2023.
//

import UIKit

extension MainController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return MainView.filteredData.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let viewModel = MainView.filteredData[indexPath.row]
        if let productsCell = tableView.dequeueReusableCell(
            withIdentifier: ProductsTableCell.reuseIdentifier,
            for: indexPath
        ) as? ProductsTableCell {
            productsCell.configure(newProduct: viewModel)
            return productsCell
        }
        return UITableViewCell()
    }
}

extension MainController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: .none
        ) { [weak self] (action, view, completion) in
            self?.handleDelete(indexPath: indexPath)
            completion(true)
        }
        deleteAction.image = UIImage(
            systemName: "trash.fill",
            withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
        )?.withTintColor(.white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

class MainController: UIViewController, UISearchBarDelegate {
    
    private var mainView = SceneDelegate.mainView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        mainView.configureUI()
        self.view.addSubview(mainView)
        mainView.pin(to: self.view, [.top: 0, .left: 0, .bottom: 0, .right: 0])
        self.setupProductsTableViewDelegate()
        self.setupSearchViewDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainView.configureSearchView()
    }
    
    private func setupProductsTableViewDelegate() {
        MainView.productsTable.delegate = self
        MainView.productsTable.dataSource = self
    }
    
    private func setupSearchViewDelegate() {
        mainView.searchView.delegate = self
    }

    public func getData() {
        ProductsList.getAllProducts()
        for product in productsList {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier:"fi_FI")
            dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
            let date = product.bestBeforeDate
            let finalDate: String = "\(date[8])\(date[9]).\(date[5])\(date[6]).\(date[0])\(date[1])\(date[2])\(date[3])"
            MainView.productsViewModels.append(ProductsViewModel(productID: product.id, productName: product.name, productBestBeforeDate: dateFormatter.date(from: finalDate)!, productQuantity: product.quantity))
        }
        checkDates()
    }
    
    public func addNewProduct(newProduct: ProductsViewModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"fi_FI")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
        let productDate = dateFormatter.string(from: newProduct.productBestBeforeDate)
        ProductsList.addProduct(product: addProduct(name: newProduct.productName, bestBeforeDate: productDate, quantity: newProduct.productQuantity))
        if let addedProduct = addedProduct {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier:"fi_FI")
            dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
            let date = addedProduct.bestBeforeDate
            let finalDate: String = "\(date[8])\(date[9]).\(date[5])\(date[6]).\(date[0])\(date[1])\(date[2])\(date[3])"
            MainView.productsViewModels.append(ProductsViewModel(productID: addedProduct.id, productName: addedProduct.name, productBestBeforeDate: dateFormatter.date(from: finalDate)!, productQuantity: addedProduct.quantity))
            checkDates()
            MainView.filteredData = MainView.productsViewModels
            mainView.filteredDataIndexes = []
            for i in MainView.productsViewModels.indices {
                mainView.filteredDataIndexes.append(i)
            }
            MainView.productsTable.reloadData()
        }
    }
    
    private func handleDelete(indexPath: IndexPath) {
        let deletedProduct = MainView.productsViewModels.remove(at: mainView.filteredDataIndexes[indexPath.row])
        ProductsList.deleteProduct(productId: deletedProduct.productID)
        if deleteStatus {
            MainView.filteredData = []
            mainView.filteredDataIndexes = []
            for i in MainView.productsViewModels.indices {
                mainView.filteredDataIndexes.append(i)
            }
            for i in mainView.filteredDataIndexes {
                MainView.filteredData.append(MainView.productsViewModels[i])
            }
            MainView.productsTable.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        MainView.filteredData = []
        mainView.filteredDataIndexes = []

        if searchText == "" {
            MainView.filteredData = MainView.productsViewModels
            for i in MainView.productsViewModels.indices {
                mainView.filteredDataIndexes.append(i)
            }
        } else {
            for i in MainView.productsViewModels.indices {
                if MainView.productsViewModels[i].productName.lowercased().contains(searchText.lowercased()) {
                    MainView.filteredData.append(MainView.productsViewModels[i])
                    mainView.filteredDataIndexes.append(i)
                }
            }
        }
        MainView.productsTable.reloadData()
    }
    
    private func checkDates() {
        let threeDaysInSec = 259200.0
        let oneDayInSec = 86400.0
        for product in MainView.productsViewModels {
            if product.productBestBeforeDate <= Date.now + threeDaysInSec && product.productBestBeforeDate >= Date.now + oneDayInSec {
                product.productStatusColor = UIColor.systemOrange
            } else if product.productBestBeforeDate <= Date.now + oneDayInSec {
                product.productStatusColor = UIColor.systemRed
            } else {
                product.productStatusColor = UIColor.black
            }
        }
    }
}
