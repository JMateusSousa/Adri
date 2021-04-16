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
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var segmentControlText: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var indicationText, contraindicationText: String!
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var translator: Translator!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setDismissKeyboard()
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        activityIndicator.hidesWhenStopped = true
    }

    @IBAction func selectSegment(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            segmentControlText.text = self.indicationText
        case 1:
            segmentControlText.text = self.contraindicationText
        default:
            break
        }
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
        activityIndicator.startAnimating()
        self.segmentControlText.isHidden = true
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
                        var textOne = indications!.joined(separator:"-")
                        if let textTwo = contraindications?.joined(separator:"-") {
                            textOne.append(" | " + textTwo)
                        }

                        self.translate(from: "en", text: textOne, completionHandler: { [weak self] text in
                            guard let self = self else { return }
                            DispatchQueue.main.async {
                                let separetedString = text.components(separatedBy: " | ")
                                self.indicationText = separetedString[0]
                                if textOne.contains("|") {
                                    self.contraindicationText = separetedString[1]
                                }
                                self.segmentControlText.text = self.indicationText
                                self.activityIndicator.stopAnimating()
                                self.segmentControlText.isHidden = false
                            }
                        })
                    }
                } else if response.statusCode == 404 {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Medicamento não encontrado.", message: errorMessage, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Entendi", style: .default))
                        self.present(alertController, animated: true, completion: nil)
                        self.activityIndicator.stopAnimating()
                        self.segmentControlText.isHidden = false
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
        save(name: (searchBar.text)!, textOne: indicationText, textTwo: contraindicationText ?? "")
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

extension SearchMedicineViewController {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            segmentControlText.text = ""
        }
    }
}
