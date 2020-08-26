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
    @IBOutlet var startTreatmentButton: UIButton!
    
    var startTreatmentHour: String = ""
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var hour: [String] = []
    static let memory = UserDefaults.standard
    var indexMedicineDay: Int = 0
    
    func fillHour() {
        hour.append("Agora")
        for index in 0...23 {
            //hour.append(String(index) + " h")
            hour.append(String(index))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillHour()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(indexMedicineDay)
    }
    
    private func getHourNow() -> String {
        let date = Date()
        var calendar = Calendar.current

        if let timeZone = TimeZone(identifier: "BRT") {
           calendar.timeZone = timeZone
        }

        let hour = String(calendar.component(.hour, from: date))
        
        return hour
    }
    
    @IBAction func toSave(_ sender: Any) {
        var stringTreatment = startTreatmentHour
        
        if stringTreatment == "Agora" {
            stringTreatment = getHourNow()
        }
        
        var index = Int(startTreatmentHour)!
        var string = stringTreatment
        
        while index + 2 <= 23 {
            index += 2
            string += "\n" + String(index)
        }
        
        let medicineHours = string
        let newMedicine = Medicine(medicineName: medicineTextField.text!, medicineHour: medicineHours)
        MainScreenController.medicines.append(newMedicine)
        do {
            try AddMedicineController.memory.setObject(newMedicine, forKey: String(indexMedicineDay) + "25/08")
            AddMedicineController.memory.set(indexMedicineDay, forKey: "indexMedicineDay")
            indexMedicineDay = 1 + indexMedicineDay
            print(indexMedicineDay)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func startTreatment(_ sender: Any) {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
}

extension AddMedicineController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hour.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.hour[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        startTreatmentButton.setTitle(String(hour[row]), for: .normal)
        startTreatmentHour = String(hour[row])
    }
}
