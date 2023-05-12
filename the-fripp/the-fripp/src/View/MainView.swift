//
//  FridgeView.swift
//  the-fripp
//
//  Created by Никита Лисунов on 21.04.2023.
//

import UIKit

class MainView: UIView {
    
    private let fridgeLabel = UILabel()
    private let topRect = UIView()
    private let bottomRect = UIView()
    static let productsTable = UITableView(frame: .zero, style: .plain)
    private let addButton = UIButton()
    private let aboutButton = UIButton()
    private let logoutButton = LogoutButton()
    public let searchView = UISearchBar()
    public let dialogMessage = UIAlertController(title: "Add new product", message: "Enter the product name, quantity and expiration date", preferredStyle: .alert)
    private var isLoading = false
    static var productsViewModels = [ProductsViewModel]()
    static var filteredData = [ProductsViewModel]()
    public var filteredDataIndexes = [Int]()
    
    public func configureUI() {
        self.backgroundColor = UIColor(hex: "CCEDFF")
        setupTopRect()
        setupFridgeLabel()
        setupBottomRect()
        setupAddButton()
        setupAboutButton()
        setupDialogMessage()
        setupSearchBar()
        setupLogoutButton()
        SceneDelegate.mainController.getData()
        MainView.filteredData = MainView.productsViewModels
        for i in MainView.productsViewModels.indices {
            filteredDataIndexes.append(i)
        }
        configureProductsTableView()
    }
    
    private func setupTopRect() {
        self.addSubview(topRect)
        topRect.pin(to: self, [.left: 0, .right: 0])
        topRect.pinTop(to: self.topAnchor)
        topRect.setHeight(to: 126)
        topRect.layer.backgroundColor = UIColor(hex: "CCEDFF").cgColor
    }
    
    private func setupFridgeLabel() {
        topRect.addSubview(fridgeLabel)
        fridgeLabel.pinTop(to: self.topAnchor, 86)
        fridgeLabel.pin(to: self, [.left: 16, .right: 201])
        fridgeLabel.text = "Your Fridge"
        fridgeLabel.textColor = .black
        fridgeLabel.font = .systemFont(
            ofSize: 32,
            weight: .regular
        )
    }
    
    private func setupBottomRect() {
        self.addSubview(bottomRect)
        bottomRect.pinBottom(to: self.bottomAnchor)
        bottomRect.pin(to: self, [.left: 0, .right: 0])
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
        addButton.pinBottom(to: self.bottomAnchor, 44)
        addButton.pin(to: self, [.left: 330, .right: 23])
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
                        let newProduct = ProductsViewModel(productID: -1, productName: curProductName, productBestBeforeDate: curProductEndDate, productQuantity: Int(curProductAmount)!)
                        SceneDelegate.mainController.addNewProduct(newProduct: newProduct)
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
        aboutButton.pinBottom(to: self.bottomAnchor, 44)
        aboutButton.pin(to: self, [.left: 23, .right: 330])
        aboutButton.addTarget(self, action: #selector(aboutButtonPressed), for: .touchDown)
    }
    
    private func configureProductsTableView() {
        setupProductsTableUI()
        setupProductsTableViewCell()
    }
    
    private func setupProductsTableUI() {
        self.addSubview(MainView.productsTable)
        MainView.productsTable.backgroundColor = .clear
        MainView.productsTable.keyboardDismissMode = .onDrag
        MainView.productsTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        MainView.productsTable.pinTop(to: searchView.bottomAnchor)
        MainView.productsTable.pinBottom(to: bottomRect.topAnchor)
        MainView.productsTable.pin(to: self, [.left: 16, .right: 16])
    }
    
    private func setupProductsTableViewCell() {
        MainView.productsTable.register(
            ProductsTableCell.self,
            forCellReuseIdentifier: ProductsTableCell.reuseIdentifier
        )
    }
    
    private func setupSearchBar() {
        self.addSubview(searchView)
        searchView.pinTop(to: topRect.bottomAnchor)
        searchView.pin(to: self, [.left: 0, .right: 0])
        searchView.searchBarStyle = .minimal
        searchView.barTintColor = UIColor.clear
        searchView.placeholder = "Search"
    }
    
    private func setupLogoutButton() {
        self.addSubview(logoutButton)
        logoutButton.pinTop(to: self.topAnchor, 100)
        logoutButton.pin(to: self, [.right: 16])
        logoutButton.setupText(
            "Logout",
            UIColor(hex: "007AFF"),
            .systemFont(ofSize: 14, weight: .regular)
        )
    }
    
    public func configureSearchView() {
        searchView.addBottomBorder(color: .white, thickness: 1.0)
    }
    
    @objc
    public func aboutButtonPressed() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        SceneDelegate.mainController.navigationController?.present(SceneDelegate.aboutController, animated: true)
    }
    
    @objc
    public func addButtonPressed() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        SceneDelegate.mainController.navigationController?.present(self.dialogMessage, animated: true)
    }
}
