//
//  UpdateViewController.swift
//  NoteApp
//
//  Created by Mehdican Büyükplevne on 27.12.2022.
//

import UIKit
import CoreData

class UpdateViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var updNoteTF: UITextField!
    @IBOutlet weak var updPinTF: UITextField!
    
    var note:Notlar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let n = note
        {
            updNoteTF.text = n.not_title
            updPinTF.text = n.not_pin
        }
    }
    
    @IBAction func guncelleButton(_ sender: Any) {
        
        if let n = note,let upNote = updNoteTF.text,let upPin = updPinTF.text
        {
            n.not_title = upNote
            n.not_pin = upPin
            appDelegate.saveContext()
            navigationController?.popViewController(animated: true)
        }
    }
}
