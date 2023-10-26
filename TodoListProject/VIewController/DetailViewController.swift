//
//  DetailViewController.swift
//  TodoListProject
//
//  Created by AHNJAEWON1 on 2023/08/26.
//  Table 목록 클릭했을 경우 넘어오는 상세페이지 

import UIKit
import SQLite3

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var tfTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var textViewtodo: UITextView!
    
    var delegate: DetailViewDelegate?
    
    
    var db: OpaquePointer?
    var todoList: [TodoList] = [] // TodoList 배열
    var receiveId = 0
    var receivetitle = ""
    var receiveTodo = ""
    var receivePhone = ""
    var receiveImage: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfTitle.text = receivetitle
        textViewtodo.text = receiveTodo
        print("dddd\(receiveId)") // 리버스 아이디 가져온다.
        print("이미지:\(receiveImage)")// 닐값이 나온다 문제가 있다,  2023.08.29 12:45 지금은 된다.
        
        
        if let imageData = loadImageData(),
           let image = UIImage(data: imageData) {
            imgView.contentMode = .scaleAspectFit
            imgView.image = image
        }
        
    }
    
    // 이미지 로드해서 가져오는 기능
    func loadImageData() -> Data? {
        var imageData: Data? = nil
        let queryString = "SELECT image FROM todolist WHERE id = ?"
        
        var stmt: OpaquePointer?
        do {
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("TodoListData.sqlite")
            if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
                print("error opening database")
                return nil
            }
            if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) == SQLITE_OK {
                sqlite3_bind_int(stmt, 1, Int32(receiveId))
                
                if sqlite3_step(stmt) == SQLITE_ROW {
                    if let imageBlob = sqlite3_column_blob(stmt, 0) {
                        let imageLength = Int(sqlite3_column_bytes(stmt, 0))
                        imageData = Data(bytes: imageBlob, count: imageLength)
                        print("실행되냐?")
                    }
                } else {
                    print("No image found.")
                }
                sqlite3_finalize(stmt)
            } else {
                print("Error preparing statement.")
            }
            sqlite3_close(db)
        } catch {
            print("Error opening database file: \(error)")
        }
        return imageData
    }
    
    
    // 숨기기 기능 ( 미구현 )
    @IBAction func swHiden(_ sender: UISwitch) {
        // isHidden 값을 업데이트하고 테이블 뷰를 갱신
        delegate?.didUpdateHiddenStatus(for: receiveId, isHidden: !sender.isOn)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    
}
