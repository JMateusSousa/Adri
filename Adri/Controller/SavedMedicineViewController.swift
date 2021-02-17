//
//  SavedMedicineViewController.swift
//  Adri
//
//  Created by José Mateus Azevedo on 04/02/21.
//  Copyright © 2021 José Mateus Azevedo. All rights reserved.
//

import UIKit

class SavedMedicineViewController: UIViewController {

    @IBOutlet weak var textViewIndicantion: UITextView!
    @IBOutlet weak var textViewContraindicantion: UITextView!

    @IBOutlet weak var navBar: UINavigationBar!

    var textOne, textTwo, name: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        textViewIndicantion.text = textOne
        textViewContraindicantion.text = textTwo
        navBar.topItem?.title = name
    }

    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
