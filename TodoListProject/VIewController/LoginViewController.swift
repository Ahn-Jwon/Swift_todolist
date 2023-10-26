//
//  LoginViewController.swift
//  TodoListProject
//
//  Created by AHNJAEWON1 on 2023/08/27.
//

import UIKit

class LoginViewController: UIViewController {
    
    var todoList: [DBModel] = []
    
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tfLogin: UITextField!
    @IBOutlet weak var tfPw: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    // 로그인 버튼
    @IBAction func btnLogin(_ sender: UIButton) {
        let uid = tfLogin.text?.trimmingCharacters(in: .whitespaces)
        let upw = tfPw.text?.trimmingCharacters(in: .whitespaces)
        
        // 입력값이 비어있으면 로그인 실패로 처리 (안넘어가게끔)
        guard let uidValue = uid, !uidValue.isEmpty,
              let upwValue = upw, !upwValue.isEmpty else {
            let resultAlert = UIAlertController(title: "결과", message: "아이디와 비밀번호를 입력하세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "네", style: .default)
            resultAlert.addAction(okAction)
            present(resultAlert, animated: true)
            return
        }

        let loginModel = LoginModel() // 인스턴스 생성  MySQLLoginModel.swift 여기 만들어 놓은 모델

        if loginModel.loginItems(uid: uidValue, upw: upwValue) {
            let resultAlert = UIAlertController(title: "결과", message: "로그인이 완료되었습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "네", style: .default, handler: { ACTION in
                self.performSegue(withIdentifier: "LoginToTableSegue", sender: nil)
            })
            resultAlert.addAction(okAction)
            present(resultAlert, animated: true)
        } else {
            let resultAlert = UIAlertController(title: "결과", message: "로그인에 실패하였습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "네", style: .default)
            resultAlert.addAction(okAction)
            present(resultAlert, animated: true)
        }
    }

        
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // ViewController


extension LoginViewController: LoginModelProtocol{
    func itemDownload(item: [DBModel]) {
        todoList = item
       
    }

}
