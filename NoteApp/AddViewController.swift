//
//  AddViewController.swift
//  NoteApp
//
//  Created by Mehdican Büyükplevne on 27.12.2022.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var addNoteTF: UITextField!
    @IBOutlet weak var addPinTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func kaydetButton(_ sender: Any) {
        
        // TEXTFİELDLARA ULAŞTIK
        if let not = addNoteTF.text,let pin = addPinTF.text
        {
            //CONTEXT YARDIMIYLA VERİLERİN KAYIT İŞLEMLERİNİ YAPTIK
            let notes = Notlar(context: context)
            notes.not_title = not
            notes.not_pin = pin
            appDelegate.saveContext()
            navigationController?.popViewController(animated: true)
        }
    }
}
