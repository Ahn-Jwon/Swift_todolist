//
//  DBModel.swift
//  DBCRUD
//
//  Created by AHNJAEWON1 on 2023/08/25.
//

// Model은 타입만 만들어놓는다
// 모델하우스를 가면 모형만 만들어 놓는것과 같다.

struct DBModel{
    var uid: String
    var upw: String
    var uphone: String
    
    // 생성자
    init(uid: String, upw: String, uphone: String){
        self.uid = uid
        self.upw = upw
        self.uphone = uphone

    }
}
