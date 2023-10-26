//
//  DBModel.swift
//  DBCRUD
//
//  Created by AHNJAEWON1 on 2023/08/25.
//

// Model은 타입만 만들어놓는다
// 모델하우스를 가면 모형만 만들어 놓는것과 같다.
import Foundation


struct TodoList {
    var id: Int
    var title: String
    var todo: String
    var imageData: Data? // 이미지 데이터를 저장하기 위한 필드
    //    var hidden: Bool // hidden 속성 추가
    
    
    
    // 생성자
    init(id: Int, title: String, todo: String, imageData: Data?) {
        self.id = id
        self.title = title
        self.todo = todo
        
        self.imageData = imageData
        //        self.hidden = hidden
        
    }
}
