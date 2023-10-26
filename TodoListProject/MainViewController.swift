////
////  MainViewController.swift
////  TodoListProject
////
////  Created by AHNJAEWON1 on 2023/08/26.
////
//
//import UIKit
//import SQLite3 // <<<<
//
//class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//
//    @IBOutlet weak var listTableView: UITableView!
//
//
//    var todoList: [TodoList] = []
//    var db: OpaquePointer?
//
//
//    // View Controller( TableContoller로 만들지 않고, ViewController에서 Table View를
//    // 넣을 경우 위에 코드를 이렇게 만들어줘야 한다.
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // SQLite 설정하기
//        // false로 되있는 부분이 true이면 매번 생성하는 것
//        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("TodoListData.sqlite")
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
//            print("error opening database")
//        }
//
//
//        // Table 만들기
//        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS todolist (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, date TExt)", nil, nil, nil) != SQLITE_OK{
//            let errMSG = String(cString: sqlite3_errmsg(db)!)
//            print("error creating table: \(errMSG)")
//            return
//        }
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        readValues()
//    }
//
//    // 기본 불러오는 기능
//    func readValues(){
//        todoList.removeAll()
//        var stmt: OpaquePointer?
//        let queryString = "SELECT * FROM todolist"
//
//        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
//            let errMSG = String(cString: sqlite3_errmsg(db)!)
//            print("error preparing select: \(errMSG)")
//            return
//        }
//
//        while sqlite3_step(stmt) == SQLITE_ROW{ //불러올 데이터가 있다면 한다는 뜻이다.
//            let id = Int(sqlite3_column_int(stmt, 0))
//            let title = String(cString: sqlite3_column_text(stmt, 1))
//            let date = String(cString: sqlite3_column_text(stmt, 2))
//            let todo = String(cString: sqlite3_column_text(stmt, 3))
//            todoList.append(TodoList(title: title, date: date, todo: todo))
//        }
//        listTableView.reloadData()
//    }
//
//    // insert 기능
//    func tempInsert(){
//        var stmt: OpaquePointer?
//        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self) // 한글처리하는 부분
//
//        let queryString = "INSERT INTO todolist (title, title, todo) VALUES (?, ?, ?)"
//        // insert 준비과정
//        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
//            let errMSG = String(cString: sqlite3_errmsg(db)!)
//            print("error preparing insert: \(errMSG)")
//            return
//        }
//
//        sqlite3_bind_text(stmt, 1, "유비", -1, SQLITE_TRANSIENT)
//        sqlite3_bind_text(stmt, 2, "컴퓨터 공학과", -1, SQLITE_TRANSIENT)
//        sqlite3_bind_text(stmt, 3, "1234", -1, SQLITE_TRANSIENT)
//
//        // insert 과정
//        if sqlite3_step(stmt) != SQLITE_DONE{
//            let errMSG = String(cString: sqlite3_errmsg(db)!)
//            print("error insert data: \(errMSG)")
//            return
//        }
//    }
//
//
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return todoList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
//
//        var content = cell.defaultContentConfiguration()
//        content.text = "제목 : \(todoList[indexPath.row].title)"
//        content.secondaryText = "작성날짜 : \(todoList[indexPath.row].date)"
//        cell.contentConfiguration = content
//
//
//        return cell
//
//         func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//            if editingStyle == .delete {
//                // Delete the row from the data source
//                let id = todoList[indexPath.row].id
////                deleteAction(id)
//                readValues()
//                //tableView.deleteRows(at: [indexPath], with: .fade)
//            } else if editingStyle == .insert {
//                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//            }
//        }
//
//
//    }
//
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
