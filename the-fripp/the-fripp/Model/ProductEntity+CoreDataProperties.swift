//
//  ProductEntity+CoreDataProperties.swift
//  the-fripp
//
//  Created by Никита Лисунов on 15.12.2022.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var amount: String?
    @NSManaged public var endDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var userEmail: String?
    @NSManaged public var user: UserEntity?

}

extension ProductEntity : Identifiable {

}
