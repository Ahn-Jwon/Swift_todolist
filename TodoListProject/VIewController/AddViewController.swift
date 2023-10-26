//
//  AddViewController.swift
//  TodoListProject
//
//  Created by AHNJAEWON1 on 2023/08/26.
//

import UIKit
import SQLite3 // <<<<


class AddViewController: UIViewController {
    
    
    @IBOutlet weak var tfdate: UITextField!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var textViewTodo: UITextView!
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    var db: OpaquePointer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("TodoListData.sqlite")
        sqlite3_open(fileURL.path, &db)
    }
        
    

        // 입력기능
        @IBAction func btnInsert(_ sender: UIButton) {
            var stmt: OpaquePointer?
            let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
            
            let title = tfTitle.text?.trimmingCharacters(in: .whitespaces)
            let todo = textViewTodo.text?.trimmingCharacters(in: .whitespaces)
        
        
     
        
        // 이미지 변환
        let selectedImage:UIImage = imgView.image!
        let imageData:NSData = selectedImage.pngData()! as NSData
        print("저장됨?\(imageData)") // 이미지 저장되는지 확인
            
        let queryString = "INSERT INTO todolist (title, todo, image) VALUES (?, ?, ?)"  // 입력 쿼리문 
         sqlite3_prepare_v2(db, queryString, -1, &stmt, nil)
         
         sqlite3_bind_text(stmt, 1, title, -1, SQLITE_TRANSIENT)
         sqlite3_bind_text(stmt, 2, todo, -1, SQLITE_TRANSIENT)
         sqlite3_bind_blob(stmt, 3, imageData.bytes, Int32(imageData.length), SQLITE_TRANSIENT)
            
            sqlite3_step(stmt)
            print("Image data successfully converted.") // 저장 잘 되었는지 확인 (용량이 나와야 한다.)
            let resultAlert = UIAlertController(title: "결과", message: "입력되었습니다.", preferredStyle: .alert) // 잘 뜨는지 알라트 띄어주기
            let okAction = UIAlertAction(title: "네", style: .default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            
            resultAlert.addAction(okAction)
            present(resultAlert, animated: true)
        
    }

    
        // 이미지 첨부버튼
        @IBAction func btnImage(_ sender: UIButton) {
            let imagePickerController = UIImagePickerController()
              imagePickerController.delegate = self
              imagePickerController.sourceType = .photoLibrary
              present(imagePickerController, animated: true, completion: nil)
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

        //  이미지 첨부버턴을 누르면 시뮬레이터 속 갤러리로 들어가 사진을 저장하는 기능.
        extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                picker.dismiss(animated: true, completion: nil)
                
                if let selectedImage = info[.originalImage] as? UIImage {
                    // Display selected image in imgView
                    imgView.image = selectedImage
                }
            }
            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                picker.dismiss(animated: true, completion: nil)
            }
        }
