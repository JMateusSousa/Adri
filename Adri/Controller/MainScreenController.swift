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
        // Coloca userDefaults no array de medicamentos
//        do {
//            let index = AddMedicineController.memory.integer(forKey: "indexMedicineDay")
//            for item in 0...index {
//                try MainScreenController.self.medicines.append(AddMedicineController.memory.getObject(forKey: String(item) + "25/08", castTo: Medicine.self))
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.delegate = self
        tableView.dataSource = self
        
//        let database = DataBase()
//        let medicines = [Medicine(medicineName: "Tylenol", medicineHour: "2\n5\n9"), Medicine(medicineName: "Dipirona", medicineHour: "18")]
//        var savedMedicines = database.load()
//        savedMedicines += medicines
//        database.save(medicines: savedMedicines)
        
        let database = DataBase()
        MainScreenController.medicines = database.load()
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
