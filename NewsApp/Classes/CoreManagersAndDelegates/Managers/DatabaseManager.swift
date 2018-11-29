//
//  DatabaseManager.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/29.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class DatabaseManager: NSObject {
    
    let field_table_name = "translation"
    let field_original_message = "original_message"
    let field_translated_message = "translated_message"
    let field_translated_audio = "translated_audio"
    let field_from_lang_code = "from_lang_code"
    let field_to_lang_code = "to_lang_code"
    let field_timestamp = "timestamp"
    
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
                    let createTableQuery = "CREATE TABLE " + field_table_name + " (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, " + field_original_message + " TEXT, " + field_translated_message + " TEXT, " + field_translated_audio + " TEXT, " + field_from_lang_code + " VARCHAR, " + field_to_lang_code + " VARCHAR, " + field_timestamp + " DATETIME DEFAULT CURRENT_TIMESTAMP);"
                    
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
    
    func insertHistoryData(originalMsg: String, translatedMsg: String, translatedAudio: String, fromLangCode: String, toLangCode: String){
        if openDatabase() {
            
            let insertQuery = "INSERT INTO \(field_table_name) (\(field_original_message), \(field_translated_message), \(field_translated_audio), \(field_from_lang_code), \(field_to_lang_code)) VALUES ('\(originalMsg)', '\(translatedMsg)', '\(translatedAudio)', '\(fromLangCode)', '\(toLangCode)');"
            
            if !database.executeStatements(insertQuery) {
                print("Failed to insert data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }
            
            database.close()
        }
    }
    
    func deleteHistoryData(ID: Int32){
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
    
    func retrieveHistoryData() -> [TranslationHistoryData]!{
        var historyObjs: [TranslationHistoryData] = []
        if openDatabase() {
            
            let retrieveQuery = "SELECT * FROM \(field_table_name) ORDER BY timestamp DESC"
            
            do {
                let results = try database.executeQuery(retrieveQuery, values: nil)
                
                while results.next() {
                    let historyObj = TranslationHistoryData(
                        data_id: results.int(forColumn: "id"),
                        originalWord: results.string(forColumn: field_original_message),
                        translatedWord: results.string(forColumn: field_translated_message),
                        fromLangCode: results.string(forColumn: field_from_lang_code),
                        toLangCode: results.string(forColumn: field_to_lang_code),
                        translatedAudio: results.string(forColumn: field_translated_audio)
                    )
                    
                    if historyObjs == nil {
                        historyObjs = [TranslationHistoryData]()
                    }
                    historyObjs.append(historyObj)
                    
                }
            } catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return historyObjs
    }
    
    func checkHistoryDataExist(originalMsg: String, fromLangCode: String, toLangCode: String) -> Bool{
        var exist = false
        
        if openDatabase() {
            let query = "SELECT * FROM \(field_table_name) WHERE \(field_original_message)=? AND \(field_from_lang_code)=? AND \(field_to_lang_code)=?"
            
            do {
                let results = try database.executeQuery(query, values: [originalMsg, fromLangCode, toLangCode])
                
                if results.next() {
                    exist = true
                } else {
                    exist = false
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        database.close()
        
        return exist
    }
    
    func updateHistoryData(originalMsg: String, fromLangCode: String, toLangCode: String) -> Bool{
        var success = true
        
        if openDatabase() {
            success = true
            
            let updateQuery = "UPDATE \(field_table_name) SET \(field_timestamp)=CURRENT_TIMESTAMP WHERE \(field_original_message)=? AND \(field_from_lang_code)=? AND \(field_to_lang_code)=?"
            
            do {
                try database.executeUpdate(updateQuery, values: [originalMsg, fromLangCode, toLangCode])
            } catch {
                print(error.localizedDescription)
                success = false
            }
            
        }
        database.close()
        
        return success
    }
}
