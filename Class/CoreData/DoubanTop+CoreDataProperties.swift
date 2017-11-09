//
//  DoubanTop+CoreDataProperties.swift
//  
//
//  Created by GhostClock on 2017/11/9.
//
//

import Foundation
import CoreData


extension DoubanTop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DoubanTop> {
        return NSFetchRequest<DoubanTop>(entityName: "DoubanTop")
    }

    @NSManaged public var alt: String?
    @NSManaged public var average: String?
    @NSManaged public var casts: String?
    @NSManaged public var collect_count: Double
    @NSManaged public var directors: String?
    @NSManaged public var genres: String?
    @NSManaged public var id: String?
    @NSManaged public var large: String?
    @NSManaged public var original_title: String?
    @NSManaged public var subtype: String?
    @NSManaged public var title: String?
    @NSManaged public var year: String?

}
