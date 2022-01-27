//
//  MyMedicinesController.swift
//  Adri
//
//  Created by José Mateus Azevedo on 13/08/20.
//  Copyright © 2020 José Mateus Azevedo. All rights reserved.
//

import UIKit
import CoreData

class MyMedicinesController: UIViewController {
    
    var tableView: UITableView!
    
    static var medicines: [NSManagedObject] = []

    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    lazy var contentView: MyMedicinesView = {
        let view = MyMedicinesView()
        return view
    }()

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
//        tableView.delegate = self
//        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Pega referência de todos os objetos persistidos como elemento de tal tabela
        let fetchrequest = NSFetchRequest<NSManagedObject>(entityName: "Medicine")

        do {
            // Passa o vetor com todos os elementos da tabela persistidos para a variável referente à tabela
            MyMedicinesController.medicines = try managedContext.fetch(fetchrequest)
//            tableView.reloadData()
        } catch let error as NSError {
            print("Data could not fatch. \(error), \(error.userInfo)")
        }
//        tableView.reloadData()
    }
    
}
//
//extension MainScreenController: UITableViewDataSource, UITableViewDelegate {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return MainScreenController.medicines.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
////        _ = MainScreenController.medicines[indexPath.row]
//        cell.medicineName.text = MainScreenController.medicines[indexPath.row].value(forKey: "name") as? String
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        // variável para guardar os bytes da imagem
//        var name: String?
//        var textOne, textTwo: String?
//
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Medicine")
//        do {
//            let foundElement = try managedContext.fetch(fetchRequest)
//            if foundElement.isEmpty {
//                print("Elemento não encontrado!")
//
//            } else {
//                let element = foundElement[indexPath.row]
//                name = element.value(forKey: "name")! as? String
//                textOne = element.value(forKey: "indication")! as? String
//                textTwo = element.value(forKey: "contraindication")! as? String
//                MainScreenController.self.medicines = try managedContext.fetch(fetchRequest)
//            }
//        } catch {
//            print(error)
//        }
//
//        tableView.deselectRow(at: indexPath, animated: true)
//        let showAndEditRecordVC = UIStoryboard(name: "SavedMedicine", bundle: nil).instantiateViewController(identifier: "SavedMedicine") as! SavedMedicineViewController
//        showAndEditRecordVC.textOne = textOne
//        showAndEditRecordVC.textTwo = textTwo
//        showAndEditRecordVC.name = name
//        showAndEditRecordVC.modalPresentationStyle = .fullScreen
//        present(showAndEditRecordVC, animated: true)
//
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            MainScreenController.medicines.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//
//            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Medicine")
//            do {
//                MainScreenController.medicines = try managedContext.fetch(fetchRequest)
//                let obj = MainScreenController.medicines[indexPath.row]
//                managedContext.delete(obj)
//                do {
//                    try managedContext.save()
//                } catch let error as NSError {
//                  print("Could not save. \(error), \(error.userInfo)")
//                }
//
//                MainScreenController.medicines = try managedContext.fetch(fetchRequest)
//            } catch let error as NSError {
//                print("Could not save. \(error), \(error.userInfo)")
//            }
//                tableView.reloadData()
//            }
//    }
//}
