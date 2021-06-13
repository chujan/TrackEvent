//
//  TaskViewController.swift
//  TrackEvent
//
//  Created by Chukwuemeka Jennifer on 24/05/2021.
//
import RealmSwift
import UIKit


class TaskViewController: UIViewController {
    
    public var item: TrackEventItem?
    public var delectionHandler: (() -> Void)?
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    private let realm = try!Realm()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    var task: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemLabel.text = item?.item
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTask))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
        
    }
   @objc func deleteTask() {
    guard let item = self.item else {
        return
    }
    realm.beginWrite()
    realm.delete(item)
    try! realm.commitWrite()
    delectionHandler?()
    navigationController?.popViewController(animated: true)
    }
    

    
}
