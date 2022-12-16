//
//  DataManager.swift
//  the-fripp
//
//  Created by Никита Лисунов on 15.12.2022.
//

import UIKit
import CoreData

class DataManager {
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ProductsModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func user(email: String, password: String) -> UserEntity {
      let user = UserEntity(context: persistentContainer.viewContext)
        user.email = email
        user.password = password
      return user
    }
    
    func product(name: String, amount: String, endDate: Date, user: UserEntity) -> ProductEntity {
        let product = ProductEntity(context: persistentContainer.viewContext)
        product.name = name
        product.amount = amount
        product.endDate = endDate
        user.addToProducts(product)
        return product
    }
    
    func users() -> [UserEntity] {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        var fetchedUsers: [UserEntity] = []
        do {
            fetchedUsers = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching users \(error)")
        }
        return fetchedUsers
    }
    
    func products(user: UserEntity) -> [ProductEntity] {
        let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        request.predicate = NSPredicate(format: "user = %@", user)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        var fetchedProducts: [ProductEntity] = []
        do {
            fetchedProducts = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching products \(error)")
        }
        return fetchedProducts
    }
    
    func deleteUser(user: UserEntity) {
      let context = persistentContainer.viewContext
      context.delete(user)
      saveContext()
    }
    
    func deleteProduct(product: ProductEntity) {
      let context = persistentContainer.viewContext
      context.delete(product)
      saveContext()
    }
}
