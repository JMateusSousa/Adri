//
//  SearchMedicineViewController.swift
//  Adri
//
//  Created by José Mateus Azevedo on 07/02/21.
//  Copyright © 2021 José Mateus Azevedo. All rights reserved.
//

import UIKit
import CoreData

class SearchMedicineViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var textViewIndication: UITextView!
    @IBOutlet weak var textViewContraindication: UITextView!

    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let medicine = searchBar.text!.lowercased()
        view.endEditing(true)
        setInformations(medicine: medicine)
    }

    func setInformations(medicine: String) {
        let url = APIRouters.search.urlMedicine(medicine: medicine)
        HTTP.get.request(url: url) {  data, response, errorMessage in

            if let errorMessage = errorMessage {
                print(errorMessage)
                return
            }

            guard let data = data, let response = response else {
                return
            }

            if response.statusCode == 200 {
                let informations = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let results = informations?["results"] as? [[String: Any]] {
                    let indications = results[0]["indications_and_usage"] as? [String]
                    let contraindications = results[0]["contraindications"] as? [String]
                    let textOne = indications!.joined(separator:"-")
                    let textTwo = contraindications!.joined(separator:"-")
                    DispatchQueue.main.async {
                        self.textViewIndication.text = textOne
                        self.textViewContraindication.text = textTwo
                    }
                }
            }
        }
    }

    @IBAction func saveButton(_ sender: Any) {
        save(name: (searchBar.text)!, textOne: textViewIndication.text, textTwo: textViewContraindication.text)
        tabBarController?.selectedIndex = 0
    }
    
    func save(name: String, textOne: String, textTwo: String) {

        // Pega a referência da tabela
        let entity = NSEntityDescription.entity(forEntityName: "Medicine", in: managedContext)!

        // Pega a referência do objeto
        let medicine = NSManagedObject(entity: entity, insertInto: managedContext)

        // Configura o objeto
        medicine.setValue(name, forKey: "name")
        medicine.setValue(textOne, forKey: "indication")
        medicine.setValue(textTwo, forKey: "contraindication")

        do {
            // Salva objeto
            try managedContext.save()
            MainScreenController.medicines.append(medicine)
            self.dismiss(animated: true, completion: nil)

        } catch let error as NSError {
            print("Data Could Not FOund. \(error), \(error.userInfo)")
        }
    }
}
