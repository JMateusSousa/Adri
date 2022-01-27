//
//  TabBarViewController.swift
//  Adri
//
//  Created by Jose Mateus Azevedo de Sousa on 26/01/22.
//  Copyright © 2022 José Mateus Azevedo. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UITabBar.appearance().tintColor = UIColor.init(displayP3Red: 93/255, green: 108/255, blue: 248/255, alpha: 1)
    
        let tabOne = MyMedicinesController()
        let tabOneBarItem = UITabBarItem(title: "Medicines", image: UIImage.init(systemName: "pills.circle"),
                                         selectedImage: UIImage.init(systemName: "pills.circle.fill"))
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwo = MedicineSearchViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Search Medicines", image: UIImage.init(systemName: "magnifyingglass.circle"),
                                          selectedImage: UIImage.init(systemName: "magnifyingglass.circle.fill"))
        tabTwo.tabBarItem = tabTwoBarItem2
        
        
        self.viewControllers = [tabOne, tabTwo]
    }
}
