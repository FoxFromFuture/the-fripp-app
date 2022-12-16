//
//  MainViewController.swift
//  the-fripp
//
//  Created by Никита Лисунов on 09.12.2022.
//

import UIKit

extension MainViewController: UITableViewDataSource {
//    func numberOfSections(
//        in tableView: UITableView
//    ) -> Int {
//        return 2
//    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
//        switch section {
//        case 0:
//            return 1
//        default:
            return MainViewController.filteredData.count
//        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
//        switch indexPath.section {
//        case 0:
//            if let searchCell = tableView.dequeueReusableCell(
//                withIdentifier: SearchCell.reuseIdentifier,
//                for: indexPath
//            ) as? SearchCell {
//                return searchCell
//            }
//        default:
            let viewModel = MainViewController.filteredData[indexPath.row]
            if let productsCell = tableView.dequeueReusableCell(
                withIdentifier: ProductsTableCell.reuseIdentifier,
                for: indexPath
            ) as? ProductsTableCell {
                productsCell.configure(newProduct: viewModel)
                return productsCell
            }
//        }
        return UITableViewCell()
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
//        if indexPath.section > 0 {
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
//        }
//        return nil
    }
}

class MainViewController: UIViewController, UISearchBarDelegate {
    private let fridgeLabel = UILabel()
    private let topRect = UIView()
    private let bottomRect = UIView()
    static let productsTable = UITableView(frame: .zero, style: .plain)
    private let addButton = UIButton()
    private let aboutButton = UIButton()
    private let searchView = UISearchBar()
    private let dialogMessage = UIAlertController(title: "Add new product", message: "Enter the product name, quantity and expiration date", preferredStyle: .alert)
    private var isLoading = false
    static var productsViewModels = [ProductsViewModel]()
    static var filteredData = [ProductsViewModel]()
    private var filteredDataIndexes = [Int]()
    public var currentUser = UserEntity()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLoading = true
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        searchView.addTopBorder(color: .white, thickness: 1.0)
        searchView.addBottomBorder(color: .white, thickness: 1.0)
    }

    private func configureUI() {
        view.backgroundColor = UIColor(hex: "CCEDFF")
        setupTopRect()
        setupFridgeLabel()
        setupBottomRect()
        setupAddButton()
        setupAboutButton()
        setupDialogMessage()
        setupSearchBar()
        getData()
        checkDates()
        MainViewController.filteredData = MainViewController.productsViewModels
        for i in MainViewController.productsViewModels.indices {
            filteredDataIndexes.append(i)
        }
        configureProductsTableView()
    }
    
    private func getData() {
        let allProducts = DataManager.shared.products(user: currentUser)
        for product in allProducts {
            MainViewController.productsViewModels.append(ProductsViewModel(productName: product.name ?? "", productAmount: product.amount ?? "", pruductEndDate: product.endDate ?? Date.now))
        }
    }
    
    private func setupTopRect() {
        view.addSubview(topRect)
        topRect.pin(to: self.view, [.left: 0, .right: 0])
        topRect.pinTop(to: self.view.topAnchor)
        topRect.setHeight(to: 126)
        topRect.layer.backgroundColor = UIColor(hex: "CCEDFF").cgColor
    }
    
    private func setupFridgeLabel() {
        topRect.addSubview(fridgeLabel)
        fridgeLabel.pinTop(to: self.view.topAnchor, 86)
        fridgeLabel.pin(to: self.view, [.left: 16, .right: 201])
        fridgeLabel.text = "Your Fridge"
        fridgeLabel.textColor = .black
        fridgeLabel.font = .systemFont(
            ofSize: 32,
            weight: .regular
        )
    }
    
    private func setupBottomRect() {
        view.addSubview(bottomRect)
        bottomRect.pinBottom(to: self.view.bottomAnchor)
        bottomRect.pin(to: self.view, [.left: 0, .right: 0])
        bottomRect.setHeight(to: 84.0)
        bottomRect.layer.backgroundColor = UIColor(hex: "DBF2FF").cgColor
        bottomRect.layer.borderWidth = 1.0
        bottomRect.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupAddButton() {
        bottomRect.addSubview(addButton)
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        addButton.setImage(image, for: .normal)
        addButton.tintColor = .black
        addButton.backgroundColor = UIColor.clear
        addButton.pinBottom(to: self.view.bottomAnchor, 44)
        addButton.pin(to: self.view, [.left: 330, .right: 23])
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchDown)
    }
    
    private func setupDialogMessage() {
        let okButton = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier:"fi_FI")
            dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
            if let curProductName = self.dialogMessage.textFields?[0].text, let curProductAmount = self.dialogMessage.textFields?[1].text, let curProductEndDateText = self.dialogMessage.textFields?[2].text {
                if curProductName != "" && curProductAmount != "" && curProductEndDateText != "" {
                    if let curProductEndDate = dateFormatter.date(from: curProductEndDateText) {
                        let newProduct = ProductsViewModel(productName: curProductName, productAmount: curProductAmount, pruductEndDate: curProductEndDate)
                        self.addNewProduct(newProduct: newProduct)
                    }
                }
            }
            self.dialogMessage.textFields?[0].text = ""
            self.dialogMessage.textFields?[1].text = ""
            self.dialogMessage.textFields?[2].text = ""
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in })
        dialogMessage.addAction(okButton)
        dialogMessage.addAction(cancelButton)
        dialogMessage.addTextField(configurationHandler: { textField in
            textField.placeholder = "Product Name"
        })
        dialogMessage.addTextField(configurationHandler: { textField in
            textField.placeholder = "Quantity"
        })
        dialogMessage.addTextField(configurationHandler: { textField in
            textField.placeholder = "Expiration Date"
        })
    }
    
    private func setupAboutButton() {
        bottomRect.addSubview(aboutButton)
        aboutButton.setImage(UIImage(systemName: "questionmark.circle", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        aboutButton.tintColor = .black
        aboutButton.backgroundColor = UIColor.clear
        aboutButton.pinBottom(to: self.view.bottomAnchor, 44)
        aboutButton.pin(to: self.view, [.left: 23, .right: 330])
        aboutButton.addTarget(self, action: #selector(aboutButtonPressed), for: .touchDown)
    }
    
    private func configureProductsTableView() {
        setupProductsTableUI()
        setupProductsTableViewDelegate()
        setupProductsTableViewCell()
    }
    
    private func setupProductsTableUI() {
        view.addSubview(MainViewController.productsTable)
        MainViewController.productsTable.backgroundColor = .clear
        MainViewController.productsTable.keyboardDismissMode = .onDrag
        MainViewController.productsTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        MainViewController.productsTable.pinTop(to: searchView.bottomAnchor)
        MainViewController.productsTable.pinBottom(to: bottomRect.topAnchor)
        MainViewController.productsTable.pin(to: self.view, [.left: 16, .right: 16])
    }
    
    private func setupProductsTableViewDelegate() {
        MainViewController.productsTable.delegate = self
        MainViewController.productsTable.dataSource = self
    }
    
    private func setupProductsTableViewCell() {
//        MainViewController.productsTable.register(
//            SearchCell.self,
//            forCellReuseIdentifier: SearchCell.reuseIdentifier
//        )
        MainViewController.productsTable.register(
            ProductsTableCell.self,
            forCellReuseIdentifier: ProductsTableCell.reuseIdentifier
        )
    }
    
    private func addNewProduct(newProduct: ProductsViewModel) {
        _ = DataManager.shared.product(name: newProduct.productName, amount: newProduct.productAmount, endDate: newProduct.pruductEndDate, user: currentUser)
        DataManager.shared.saveContext()
        MainViewController.productsViewModels.append(newProduct)
        checkDates()
        MainViewController.filteredData = MainViewController.productsViewModels
        filteredDataIndexes = []
        for i in MainViewController.productsViewModels.indices {
            filteredDataIndexes.append(i)
        }
        MainViewController.productsTable.reloadData()
    }
    
    private func setupSearchBar() {
        view.addSubview(searchView)
        searchView.pinTop(to: topRect.bottomAnchor)
        searchView.pin(to: self.view, [.left: 0, .right: 0])
        searchView.searchBarStyle = .minimal
        searchView.barTintColor = UIColor.clear
        searchView.delegate = self
        searchView.placeholder = "Search"
    }
    
    private func handleDelete(indexPath: IndexPath) {
        let deletedProduct = MainViewController.productsViewModels.remove(at: filteredDataIndexes[indexPath.row])
        let allProducts = DataManager.shared.products(user: currentUser)
        for product in allProducts {
            if product.name == deletedProduct.productName && product.amount == deletedProduct.productAmount && product.endDate == deletedProduct.pruductEndDate {
                DataManager.shared.deleteProduct(product: product)
                break
            }
        }
//        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: dataSource, requiringSecureCoding: true) {
//            userDefaults.set(savedData, forKey: "dataSource")
//        }
        MainViewController.filteredData = []
        filteredDataIndexes = []
        for i in MainViewController.productsViewModels.indices {
            filteredDataIndexes.append(i)
        }
        for i in filteredDataIndexes {
            MainViewController.filteredData.append(MainViewController.productsViewModels[i])
        }
        MainViewController.productsTable.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        MainViewController.filteredData = []
        filteredDataIndexes = []
        
        if searchText == "" {
            MainViewController.filteredData = MainViewController.productsViewModels
            for i in MainViewController.productsViewModels.indices {
                filteredDataIndexes.append(i)
            }
        } else {
            for i in MainViewController.productsViewModels.indices {
                if MainViewController.productsViewModels[i].productName.lowercased().contains(searchText.lowercased()) {
                    MainViewController.filteredData.append(MainViewController.productsViewModels[i])
                    filteredDataIndexes.append(i)
                }
            }
        }
        MainViewController.productsTable.reloadData()
    }
    
    private func checkDates() {
        let threeDaysInSec = 259200.0
        let oneDayInSec = 86400.0
        for product in MainViewController.productsViewModels {
            if product.pruductEndDate <= Date.now + threeDaysInSec && product.pruductEndDate >= Date.now + oneDayInSec {
                product.productStatusColor = UIColor.systemOrange
            } else if product.pruductEndDate <= Date.now + oneDayInSec {
                product.productStatusColor = UIColor.systemRed
            } else {
                product.productStatusColor = UIColor.black
            }
        }
    }
    
    @objc
    private func aboutButtonPressed() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        self.navigationController?.present(SceneDelegate.aboutViewController, animated: true)
    }
    
    @objc
    private func addButtonPressed() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        self.navigationController?.present(dialogMessage, animated: true)
    }
}
