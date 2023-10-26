//
//  TableViewController.swift
//  TodoListProject
//
//  Created by AHNJAEWON1 on 2023/08/27.
//

import UIKit
import SQLite3 // <<<<

class TableViewController: UITableViewController, UISearchBarDelegate {
    
    // 최초 정의
    @IBOutlet var tvListView: UITableView!
    
    
    @IBOutlet weak var search: UISearchBar!
    var todoList: [TodoList] = []  // SQLite 데이터 리스트 배열
    var mysqltodoList: [DBModel] = [] // MySQL 로그인 회원가입 데이터 리스트 배열
    var db: OpaquePointer? // SQLite db 변수명
    var currentDate = Date()
    
    //    var isOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        // SQLite 설정하기
        // false로 되있는 부분이 true이면 매번 생성하는 것
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("TodoListData.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        
        // Table 만들기
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS todolist (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, todo TEXT, image BLOB, date DATETIME)", nil, nil, nil) != SQLITE_OK {
            let errMSG = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errMSG)")
            return
        }
        
        
    }
    
    
    
    // Viewdidload 대용 하는 기능
    override func viewWillAppear(_ animated: Bool) {
        readValues()
        
    }
    
    // 기본 불러오는 기능
    func readValues() {
        todoList.removeAll()
        var stmt: OpaquePointer?
        let queryString = "SELECT id, title, todo, image FROM todolist" // Include the image column
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errMSG = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errMSG)")
            return
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            let id = Int(sqlite3_column_int(stmt, 0))
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let todo = String(cString: sqlite3_column_text(stmt, 2))
    
            
            // Load image data
            let imageDataPtr = sqlite3_column_blob(stmt, 3)
            let imageDataSize = sqlite3_column_bytes(stmt, 3)
            let imageData = imageDataPtr != nil ? Data(bytes: imageDataPtr!, count: Int(imageDataSize)) : nil
            
            todoList.append(TodoList(id: id, title: title, todo: todo, imageData: imageData))
        }
        tvListView.reloadData()
    }
    
    
    
    // insert 기능 (최초 데이터값)
    func tempInsert(){
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "INSERT INTO todolist (title, todo) VALUES (?, ?)"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errMSG = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errMSG)")
            return
        }
        
        sqlite3_bind_text(stmt, 1, "안녕", -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, "ㅇㄴㅁㅇㅇ", -1, SQLITE_TRANSIENT)
        //        sqlite3_bind_text(stmt, 3, "111", -1, SQLITE_TRANSIENT)
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errMSG = String(cString: sqlite3_errmsg(db)!)
            print("error insert data: \(errMSG)")
            return
        }
    }
    
    
    // 서치바 (검색기능 구현) 2023/ 09.02
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // searchText를 사용하여 데이터를 검색하고, 검색 결과를 업데이트
        // 여기에서 검색 기능을 구현
        // 검색 결과를 새로운 배열에 저장하고, 해당 배열을 테이블 뷰에 로드
        // 검색 결과를 표시하려면 todoList 배열 대신 검색 결과 배열사용
        
        if searchText.isEmpty {
            // 검색 바가 비어있을 때, 모든 항목을 표시
            readValues()
        } else {
            // 검색 바에 입력된 텍스트로 검색 결과를 필터링
            let searchTextLowercased = searchText.lowercased()
            let filteredResults = todoList.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            // 필터링된 결과를 사용하여 테이블 뷰를 업데이트
            todoList = filteredResults
            tvListView.reloadData()
        }
    }
    
    
    
    // MARK: - Table view data source
    
    // 테이블의 열 지정
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // 테이블 높이 지정 heightForRowA (강제 높이 지정)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // 테이블의 컨텐츠 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
        
        cell.lblTitle.text = "\(todoList[indexPath.row].title)"
        cell.imgView.image = UIImage(data: todoList[indexPath.row].imageData!)!
        
        // 이전에 생성된 currentDate를 사용하여 날짜를 표시합니다.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // 적절한 날짜 포맷을 선택하세요.
        cell.lbldate.text = dateFormatter.string(from: currentDate)
        
        return cell
    }

    
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    // 밀어서 삭제하기
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //            tableView.deleteRows(at: [indexPath], with: .fade)
            let id = todoList[indexPath.row].id
            deleteAction(id)
            readValues()
        } else if editingStyle == .insert {
            
            
        }
    }
    
    
    
    
    
    // 삭제기능 ( 밀어서 삭제 기능)
    func deleteAction(_ id: Int){
        var stmt: OpaquePointer?
        let queryString = "DELETE FROM todolist WHERE id = ?"
        sqlite3_prepare(db, queryString, -1, &stmt, nil) // 준비
        sqlite3_bind_int(stmt, 1, Int32(id)) // ?에 넣어주기
        sqlite3_step(stmt) // 실행
    }
    
    
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     
     
     
     */
    
    // 데이터를 세그로 넘겨줄때 필요한 코드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            
            let detailView = segue.destination as! DetailViewController
            
            detailView.receiveId = todoList[indexPath!.row].id
            detailView.receivetitle = todoList[indexPath!.row].title
            detailView.receiveTodo = todoList[indexPath!.row].todo
            detailView.receiveImage = todoList[indexPath!.row].imageData
            
            
            
        }
        
        
    } //
    
    
} // TableViewController


// 스위치 프로토콜
protocol DetailViewDelegate: AnyObject {
    func didUpdateHiddenStatus(for id: Int, isHidden: Bool)
}

