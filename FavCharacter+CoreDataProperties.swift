//
//  FavCharacter+CoreDataProperties.swift
//  MarvelApp
//
//  Created by Octavio on 12/05/24.
//
//

import Foundation
import CoreData


extension FavCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavCharacter> {
        return NSFetchRequest<FavCharacter>(entityName: "FavCharacter")
    }

    @NSManaged public var name: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var descrip: String?
    @NSManaged public var url: String?

}

extension FavCharacter : Identifiable {

}
