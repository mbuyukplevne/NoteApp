//
//  NameTableViewCell.swift
//  NoteApp
//
//  Created by Mehdican Büyükplevne on 27.12.2022.
//

import UIKit

class NameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
