//
//  ViewController.swift
//  NoteApp
//
//  Created by Mehdican Büyükplevne on 27.12.2022.
//

import UIKit
import CoreData

//VERİ TABANI İLE İLGİLİ İŞLEMLERİ YAPABİLMEK İÇİN "APPDELEGATE" OLUŞTURDUK
let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    //VERİ TABANINDA SİLME VE GÜNCELLEME İŞLEMLERİ İÇİN OLUŞTURDUK
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var noteArray = [Notlar]()
    
    //ARAMA YAPILIP YAPILMADIĞINI KONTROL ETMEK İÇİN (SEARCHBAR,WİLLAPPEAR,DELETE)
    var isThereASearch = false
    var searchWord : String?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        getAllData()
        
        //TABLEVİEW METOTLARINA ULAŞMAK İÇİN DELEGATE VE DATASOURCE PROTOCOLLER
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }

    override func viewWillAppear(_ animated: Bool)
    {
        if isThereASearch
        {
            willSearch(not_title: searchWord!)
        } else {
            getAllData()
        }
        
        //ARAYÜZÜ GÜNCELLEMEK İÇİN ->
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let indeks = sender as? Int
        
        if segue.identifier == "toDetails"
        {
            let toVC = segue.destination as! DetailsViewController
            toVC.note = noteArray[indeks!]
        }
        if segue.identifier == "toUpdate"
        {
            let toVC = segue.destination as! UpdateViewController
            toVC.note = noteArray[indeks!]
        }
    }
    
    //CORE DATADAN TÜM VERİLERİ ALIYORUZ
    func getAllData() {
        
        do {
            noteArray = try context.fetch(Notlar.fetchRequest())
        } catch  {
            print(error)
        }
    }
    func willSearch(not_title:String) {
        
        let fetchRequest:NSFetchRequest<Notlar> = Notlar.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "not_title CONTAINS %@", not_title)
        
        do {
            noteArray = try context.fetch(fetchRequest)
        } catch  {
            print(error)
        }
    }
    
}
//TABLEVİEW İÇİN "EXTENSION" OLUŞTURDUK
extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return noteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let note = noteArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "toCell", for: indexPath) as! NameTableViewCell
        cell.cellLabel.text = "\(note.not_title!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "toDetails", sender: indexPath.row)
    }
    // SİLME VE GÜNCELLEME İŞLEMLERİNİ YAPTIK ->
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        //SİLME İŞLEMİ İÇİN ->
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil", handler: {(contextualAction, view, boolValue) in
            
            let note = self.noteArray[indexPath.row]
            self.context.delete(note)
            appDelegate.saveContext()
            
            //SİLME İŞLEMİ OLDUKTAN SONRA ARAYÜZÜ GÜNCELLEYİP VERİLERİ TEKRAR ÇEKTİK
            if self.isThereASearch {
                self.willSearch(not_title: self.searchWord!)
            } else {
                self.getAllData()
            }
            tableView.reloadData()
        })
        //GÜNCELLEME İŞLEMİ İÇİN ->
        let updateAction =  UIContextualAction(style: .normal, title: "Güncelle", handler: {(contextualAction, view, boolValue) in
            self.performSegue(withIdentifier: "toUpdate", sender: indexPath.row)
        })
        return UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
    }
}
//SEARCHBAR İÇİN "EXTENSION" OLUŞTURDUK
extension ViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        searchWord = searchText
        if searchText == "" {
            isThereASearch = false
            getAllData()
        } else {
            isThereASearch = true
            willSearch(not_title: searchWord!)
        }
        tableView.reloadData()
    }
}


