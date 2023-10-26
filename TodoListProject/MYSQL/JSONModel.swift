//
//  JSONModel.swift
//  TodoListProject
//
//  Created by AHNJAEWON1 on 2023/08/26.
//

// 여기 있는 Property 이름은 JSON내용과 같아야 한다.
// JSON으로 코더블이 바꿔주기 때문
struct StudentJSON: Codable{
    var uid: String
    var upw: String

}
