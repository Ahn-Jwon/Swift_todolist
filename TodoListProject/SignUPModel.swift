//
//  SignUPModel.swift
//  TodoListProject
//
//  Created by AHNJAEWON1 on 2023/08/27.
//

import Foundation
class InsertModel{
    var urlPath = "http://localhost:8080/ios/student_insert_ios.jsp"
    
    func insertItems(code: String, name: String, dept: String, phone: String) -> Bool{
        var result:Bool = true
        let urlAdd = "?code=\(code)&name=\(name)&dept=\(dept)&phone=\(phone)"
        
        urlPath = urlPath + urlAdd
        
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
//        // >>> OLD Version
//        let url: URL = URL(string: urlPath)!
//        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
//
//        let task = defaultSession.dataTask(with: url){(data, response, error) in
//            if error != nil{
//                print("Failed to insert data")
//                result = false
//            }else{
//                print("Data is inserted!")
//                result = true
//            }
//
//        }
//        task.resume()
//        -----------------------------------------------
        let url: URL = URL(string: urlPath)!
        
        DispatchQueue.global().async {
            do{
                _ = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    result = true
                }
            }catch{
                print("Failed to insert data")
                result = false
            }
        }
        return result
    }
    
}

