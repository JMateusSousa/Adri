//
//  MyMedicinesView.swift
//  Adri
//
//  Created by Jose Mateus Azevedo de Sousa on 26/01/22.
//  Copyright © 2022 José Mateus Azevedo. All rights reserved.
//

import UIKit

class MyMedicinesView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(displayP3Red: 93/255, green: 108/255, blue: 248/255, alpha: 1)
        addSubViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Medicines"
        label.font = UIFont.systemFont(ofSize: 34, weight: .regular)
        label.textColor = UIColor.init(displayP3Red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        label.textAlignment = .center
        return label
    }()

    lazy var tableView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24
        view.backgroundColor = .white

        return view
    }()
    
    func addSubViews() {
        self.addSubview(titleLabel)
        self.addSubview(tableView)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}
