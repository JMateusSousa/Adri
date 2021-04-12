//
//  SearchMedicineViewController.swift
//  Adri
//
//  Created by José Mateus Azevedo on 07/02/21.
//  Copyright © 2021 José Mateus Azevedo. All rights reserved.
//

import UIKit
import CoreData
import MLKit

class SearchMedicineViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var textViewIndication: UITextView!
    @IBOutlet weak var textViewContraindication: UITextView!

    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var translator: Translator!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setDismissKeyboard()
    }

    func setDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func didTapView() {
        view.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let medicine = searchBar.text!.lowercased()
        view.endEditing(true)
        setInformations(medicine: medicine)
    }

    func setInformations(medicine: String) {
        var medicineTranslation: String = ""
        translate(from: "pt", text: medicine, completionHandler: { [weak self] text in
            guard self != nil else { return }
            DispatchQueue.main.async {
                medicineTranslation = text.lowercased()
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {

            let url = APIRouters.search.urlMedicine(medicine: medicineTranslation)
            print(medicineTranslation)
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

                        self.translate(from: "en", text: textOne + " | " + textTwo, completionHandler: { [weak self] text in
                            guard let self = self else { return }
                            DispatchQueue.main.async {
                                    let separetedString = text.components(separatedBy: " | ")
                                    self.textViewIndication.text = separetedString[0]
                                    self.textViewContraindication.text = separetedString[1]
                            }
                        })
                    }
                }
            }
        }
    }

    private func translate(from: String, text: String, completionHandler: @escaping (String) -> Void) {
        var options = TranslatorOptions(sourceLanguage: .english, targetLanguage: .portuguese)
        if from.elementsEqual("pt") {
            options = TranslatorOptions(sourceLanguage: .portuguese, targetLanguage: .english)
        }

        let englishPortugueseTranslator = Translator.translator(options: options)
        let conditions = ModelDownloadConditions(
            allowsCellularAccess: false,
            allowsBackgroundDownloading: true
        )

        englishPortugueseTranslator.downloadModelIfNeeded(with: conditions) { error in
            guard error == nil else { return }

            // Model downloaded successfully. Okay to start translating.
            englishPortugueseTranslator.translate(text) { translatedText, error in
                        guard error == nil, let translatedText = translatedText else { return }
                completionHandler(translatedText)
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
