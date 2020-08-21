//
//  ViewController.swift
//  Adri
//
//  Created by José Mateus Azevedo on 13/08/20.
//  Copyright © 2020 José Mateus Azevedo. All rights reserved.
//
import Foundation
import UIKit

class MainScreenController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    static var medicines = [Medicine]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let medicine = Medicine(medicineName: "Tylenol", medicineHour: "10 h \n18 h")
        MainScreenController.self.medicines.append(medicine)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
        
}

extension MainScreenController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainScreenController.medicines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        _ = MainScreenController.medicines[indexPath.row]
        cell.medicineName.text = MainScreenController.medicines[indexPath.row].medicineName
        cell.medicineHour.text = MainScreenController.medicines[indexPath.row].medicineHour
        return cell
    }
}
