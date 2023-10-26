//
//  SignUpViewController.swift
//  TodoListProject
//
//  Created by AHNJAEWON1 on 2023/08/27.
//

import UIKit

// 회원가입 Page
class SignUpViewController: UIViewController {
    

    // ID를 입력하는 TextFiled
    @IBOutlet weak var tfId: UITextField!
    // ID 자동 중복확인
    @IBOutlet weak var lblMessage: UILabel!
    // Password를 입력하는 TextFiled
    @IBOutlet weak var tfPassword: UITextField!
    // Password를 한번 더 입력하는 TextFiled
    @IBOutlet weak var tfPasswordCk: UITextField!
//    // Password 확인 여부
//    @IBOutlet weak var lblPwMessage: UILabel!
    // Phone번호를 입력하는 TextFiled
    @IBOutlet weak var tfPhone: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        lblMessage.text = ""

        // Do any additional setup after loading the view.
    }


    // 회원가입 완료 버튼
    @IBAction func btnInsert(_ sender: Any) {

            let uid = tfId.text?.trimmingCharacters(in: .whitespaces)
            let upw = tfPassword.text?.trimmingCharacters(in: .whitespaces)
            let uphone = tfPhone.text?.trimmingCharacters(in: .whitespaces)

            let signupModel = SignUpModel()

            signupModel.checkDuplicateId(uid: uid!) { isAvailable in
                DispatchQueue.main.async {
                    if !isAvailable {
                        // 중복일 경우
                        self.lblMessage.textColor = UIColor.red
                        self.lblMessage.text = "사용할 수 없는 아이디입니다."
                    } else {
                        // 중복이 아닐 경우
                        self.lblMessage.textColor = UIColor.green
                        self.lblMessage.text = "사용 가능한 아이디입니다."

                        if signupModel.signupItems(uid: uid!, upw: upw!, uphone: uphone!) {
                            let resultAlert = UIAlertController(title: "결과", message: "회원가입이 완료되었습니다.", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "확인", style: .default) { _ in
                                self.navigationController?.popViewController(animated: true)
                            }
                            resultAlert.addAction(okAction)
                            self.present(resultAlert, animated: true)
                        } else {
                            let resultAlert = UIAlertController(title: "결과", message: "회원가입에 실패하였습니다.", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "확인", style: .default)
                            resultAlert.addAction(okAction)
                            self.present(resultAlert, animated: true)
                        }
                    }
                }
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

}
