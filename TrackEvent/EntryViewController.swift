//
//  EntryViewController.swift
//  TrackEvent
//
//  Created by Chukwuemeka Jennifer on 24/05/2021.
//
import RealmSwift
import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var field: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
  //  var update: (() -> Void)?
    private let realm = try! Realm()
    public var completionHandler: (()-> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        field.becomeFirstResponder()
        field.delegate = self
        datePicker.setDate(Date(), animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @ objc func didTapSaveButton() {
        if let text = field.text,!text.isEmpty {
            let date = datePicker.date
            let newItem = TrackEventItem()
            newItem.date = date
            newItem.item = text
            realm.beginWrite()
            realm.add(newItem)
            
            try! realm.commitWrite()
            completionHandler?()
            navigationController?.popViewController(animated: true)
            
        }
        else{
            print("Add something")
        }
        
    }
  //  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //    saveTask()
      //  return true
  //  }
  //  @objc func saveTask(){
    //    guard let text = textfield.text, !text.isEmpty else {
       //     return
      //  }
      //  guard let count = UserDefaults().value(forKey: "count") as? Int else{
        //    return
       // }
       // let newCount = count + 1
      //  UserDefaults().set(newCount, forKey: "count")
      //  UserDefaults().set(text, forKey: "task_\(newCount)")
        
   //     update?()
     //   navigationController?.popViewController(animated: true)
        
 //   }
    

   
}
