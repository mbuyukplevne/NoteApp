//
//  DetailsViewController.swift
//  NoteApp
//
//  Created by Mehdican Büyükplevne on 27.12.2022.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var pinLabel: UILabel!
    
    var note : Notlar?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let n = note
        {
            noteLabel.text = n.not_title
            pinLabel.text = n.not_pin
        }
    }
}
