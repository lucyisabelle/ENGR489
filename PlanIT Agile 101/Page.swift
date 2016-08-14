//
//  Page.swift
//  PlanIT Agile 101
//
//  Created by Lucy French on 28/06/16.
//  Copyright © 2016 Lucy French. All rights reserved.
//

import UIKit

class Page: NSObject {
    
    var items = [String]()
    var sectionId = Int()
    
    //dictionary that maps item id's to their type
    var itemTypes = [Int: String]()
    //dictionary that maps item id's to their ordering within the section 
    var sectionOrder = [Int:Int]()
    
    // MARK: Initialization
    
 /**
 
 //page = Page(sectionId: sectionId)!
 //TODO Move this stuff to the page class.
 for id in itemIds{
 let query2SQL = "SELECT itemid, item FROM text WHERE itemid = \(id);"
 let results2:FMResultSet? = agileDB.executeQuery(query2SQL, withArgumentsInArray: nil)
 
 while results2?.next() == true {
 page.items += [results2!.stringForColumn("item")]
 }
 **/ 
 
}