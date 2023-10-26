//
//  MySQLSignUpModel.swift
//  TodoListProject
//
//  Created by AHNJAEWON1 on 2023/08/27.
//  My SQL 회원가입 Model
//
protocol LoginModelProtocol{
    func itemDownload(item: [DBModel])
}



import Foundation
class LoginModel{
    var urlPath = "http://localhost:8080/ios/todolist_login_ios.jsp"
    
    func loginItems(uid: String, upw: String) -> Bool {
        var result:Bool = false
        let urlAdd = "?uid=\(uid)&upw=\(upw)"
        
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
        
        do {
            let res = try Data(contentsOf: url)
            let resUtf8 = String(data: res, encoding: .utf8)!.trimmingCharacters(in: ["\r", "\n"])
            if resUtf8 == "succ" {
                result = true
            } else {
                result = false
            }
        } catch {
            print("Failed to insert data")
            result = false
        }
        
        return result
    }
    
}
