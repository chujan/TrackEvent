//
//  ViewController.swift
//  TrackEvent
//
//  Created by Chukwuemeka Jennifer on 24/05/2021.
//

import UIKit
import FSCalendar
import RealmSwift



class TrackEventItem: Object {
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()
}

class ViewController: UIViewController, FSCalendarDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    private var data = [TrackEventItem]()
    private let realm = try! Realm()
    
    var tasks = [String]()
    var calendar = FSCalendar()

    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(TrackEventItem.self).map({$0})
        calendar.delegate = self
        self.title = "tasks"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        
        updateTasks()
    }
    
   
    
    
    func updateTasks(){
        tasks.removeAll()
        
        guard  let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        for x in 0..<count{
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
                
            }
            
        }
        
        tableView.reloadData()
        
    }
    @IBAction func didTapAdd() {
        guard let vc = storyboard?.instantiateViewController(identifier: "entry") as? EntryViewController else{
            return
        }
        vc.completionHandler = {[weak self] in
            self?.refresh()
        }
        vc.title = "New Item"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
       // let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
       // vc.title = "New Task"
       // vc.update = {
         //   DispatchQueue.main.async {
           //     self.updateTasks()
           // }
            
            
        }
        //navigationController?.pushViewController(vc, animated: true)
        
    }


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = data[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(identifier: "task") as? TaskViewController else{
            return
        }
        navigationController?.pushViewController(vc, animated: true)
        vc.item = item
        vc.delectionHandler = {[weak self] in
            self?.refresh()
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = item.item
        

        }
    
    func refresh() {
        data = realm.objects(TrackEventItem.self).map({$0})
        tableView.reloadData()
        
    }
        
        }
    
    
    

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = data[indexPath.row].item
        return cell
    }
    
    
    
    
}
