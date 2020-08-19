//
//  Medicine.swift
//  Adri
//
//  Created by José Mateus Azevedo on 19/08/20.
//  Copyright © 2020 José Mateus Azevedo. All rights reserved.
//

import Foundation

class Medicine: NSObject {
    let medicineName: String
    let medicineHour: String
    
    init(medicineName: String, medicineHour: String) {
        self.medicineName = medicineName
        self.medicineHour = medicineHour
    }
}
