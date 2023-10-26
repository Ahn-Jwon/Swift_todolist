//
//  MySQLSignUpModel.swift
//  TodoListProject
//
//  Created by AHNJAEWON1 on 2023/08/27.
//  My SQL 회원가입 Model
//



import Foundation


class SignUpModel{
    var urlPath = "http://localhost:8080/ios/todolist_signup_ios.jsp"
    
    
    func checkDuplicateId(uid: String, completion: @escaping (Bool) -> Void) {
        let url = URL(string: urlPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let bodyData = "uid=\(uid)"
        request.httpBody = bodyData.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    // 중복되지 않은 경우에는 "available"이 아니므로 반대로 설정
                    DispatchQueue.main.async {
                        completion(responseString != "available")
                    }
                }
            }
        }
        task.resume()
    }

    


    func signupItems(uid: String, upw: String, uphone: String) -> Bool{
        var result:Bool = true
        let urlAdd = "?uid=\(uid)&upw=\(upw)&uphone=\(uphone)"

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
