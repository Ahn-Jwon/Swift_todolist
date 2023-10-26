//
//  TableViewCell.swift
//  TodoListProject
//
//  Created by AHNJAEWON1 on 2023/08/29.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tv1111: UITextView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        if self.imgView.image == nil {
            self.imgView.image = UIImage(named: "aaa")
        }
        print("cell")
        print(self.imgView.image)
        // Initialization code
        self.imgView.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
