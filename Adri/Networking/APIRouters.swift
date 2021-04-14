//
//  APIRouters.swift
//  Adri
//
//  Created by José Mateus Azevedo on 29/03/21.
//  Copyright © 2021 José Mateus Azevedo. All rights reserved.
//

import Foundation

enum APIRouters: Router {

    case search

    var hostname: String {
        get {
            return "https://api.fda.gov"
        }
    }

    func urlMedicine(medicine: String) -> URL? {
        return URL(string: url! + medicine)
    }

    var url: String? {
        get {
            switch self {
            case .search: return "\(hostname)/drug/label.json?search=indications_and_usage:"
            }
        }
    }
}
