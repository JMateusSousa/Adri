//
//  SavedMedicineViewController.swift
//  Adri
//
//  Created by José Mateus Azevedo on 04/02/21.
//  Copyright © 2021 José Mateus Azevedo. All rights reserved.
//

import UIKit

class SavedMedicineViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var segmentControlText: UITextView!
    @IBOutlet weak var navBar: UINavigationBar!

    var textOne, textTwo, name: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControlText.text = textOne
        navBar.topItem?.title = name
    }

    @IBAction func selectSegment(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            segmentControlText.text = self.textOne
        case 1:
            segmentControlText.text = self.textTwo
        default:
            break
        }
    }

    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
