//
//  DBHelper.swift
//  WorldNews
//
//  Created by Arman Merchant on 04/12/21.
//

import Foundation
import SQLite3

class DBHelper{
    var db : OpaquePointer?
    var path : String = "FAQDatabase.sqlite"
        init() {
            self.db = createDB()
            self.createTable()
        }
        //MARK:- Initializes the database
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("Database creation ERROR")
            return nil
        }else {
            print("Database has been created with path \(path)")
            return db
        }
    }
    //MARK:- Create the table
    func createTable()  {
        let query = "CREATE TABLE IF NOT EXISTS faq_table(id INTEGER PRIMARY KEY AUTOINCREMENT,question TEXT, answer TEXT);"
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Table created successfully")
            }else {
                print("ERROR in table creation")
            }
        } else {
            print("Prepration fail")
        }
    }
    //MARK:- Insert into db
    func insert(question : String, answer : String) {
            let query = "INSERT INTO faq_table (id, question, answer) VALUES (?, ?, ?);"
            
            var statement : OpaquePointer? = nil
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
                
                sqlite3_bind_int(statement, 1, 1)
                sqlite3_bind_text(statement, 2, (question as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 3, (answer as NSString).utf8String, -1, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Data inserted successfully")
                }else {
                    print("Data is not inserted in table")
                }
            } else {
              print("Insert Query is incorrect")
            }
            
        }
        
        //MARK:- Read data from db
        func read() -> [FAQ] {
            var mainList = [FAQ]()
            
            let query = "SELECT * FROM faq_table ;"
            var statement : OpaquePointer? = nil
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
                while sqlite3_step(statement) == SQLITE_ROW {
                    let id = Int(sqlite3_column_int(statement, 0))
                    let question = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    let answer = String(describing: String(cString: sqlite3_column_text(statement, 2)))

                    let model = FAQ()
                    model.id = id
                    
                    model.question = question
                    model.answer = answer
                                    
                    mainList.append(model)
                }
            }
            return mainList
        }
    //MARK:- Delete data from db
    func deleteItem(id:Int){
        let query = "DELETE FROM faq_table where id = \(id)"
                var statement : OpaquePointer? = nil
                if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
                    if sqlite3_step(statement) == SQLITE_DONE {
                        print("Data delete successfully")
                    }else {
                        print("Data is not deleted in table")
                    }
                }
    }
    //MARK:- Update data from db
    func update(id : Int, question : String, answer : String) {
            let query = "UPDATE faq_table SET question = '\(question)', answer = '\(answer)' WHERE id = \(id);"
            var statement : OpaquePointer? = nil
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Data updated success")
                }else {
                    print("Data is not updated in table")
                }
            }
        }
}
