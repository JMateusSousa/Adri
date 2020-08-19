//
//  AddMedicineController.swift
//  Adri
//
//  Created by José Mateus Azevedo on 19/08/20.
//  Copyright © 2020 José Mateus Azevedo. All rights reserved.
//

import UIKit

class AddMedicineController: UIViewController {
    
    @IBOutlet weak var medicineTextField: UITextField!
    @IBOutlet weak var treatmentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toSave(_ sender: Any) {
        let newMedicine = Medicine(medicineName: medicineTextField.text!, medicineHour: treatmentTextField.text!)
        MainScreenController.medicines.append(newMedicine)
        print("\(MainScreenController.medicines.count)")
    }
}
