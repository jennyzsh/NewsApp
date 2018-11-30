//
//  DatabaseManager.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/29.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit
import SwiftyJSON

class DatabaseManager: NSObject {
    
    let field_table_name = "saved_passage"
    let field_passage = "passage"
    let field_title = "title"
    
    static let shared = DatabaseManager()
    
    let databaseFileName = "database.sqlite"
    
    var pathToDatabase: String!
    
    var database: FMDatabase!
    
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    func createDatabase() -> Bool {
        
        var created = false
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    let createTableQuery = "CREATE TABLE " + field_table_name + " (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, " + field_passage + " TEXT, " + field_title + " TEXT);"
                    
                    do {
                        try database.executeUpdate(createTableQuery, values: nil)
                        created = true
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
        return created
    }

    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }

    func insertSavedPassage(title: String, passage: String){
        if openDatabase() {
            
            let insertQuery = "INSERT INTO \(field_table_name) (\(field_title), \(field_passage)) VALUES ('\(title)', '\(passage)');"
            
            if !database.executeStatements(insertQuery) {
                print("Failed to insert data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }
            
            database.close()
        }
    }
    
    func deletePassage(ID: Int32){
        if openDatabase() {
            let deleteQuery = "DELETE FROM \(field_table_name) WHERE id = ?"
            do {
                try database.executeUpdate(deleteQuery, values: [ID])
            } catch {
                print(error.localizedDescription)
            }
            database.close()
        }
    }
    
    func retrieveSavedPassage() -> Array<Any>{
        var array = Array<Any>()
        if openDatabase() {
            
            let retrieveQuery = "SELECT * FROM \(field_table_name) ORDER BY id DESC"
            
            do {
                let results = try database.executeQuery(retrieveQuery, values: nil)
                while results.next() {
                    array.append(results.resultDictionary)
                }
                
            } catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return array
    }

}
