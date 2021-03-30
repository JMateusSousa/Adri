//
//  Router.swift
//  Adri
//
//  Created by José Mateus Azevedo on 29/03/21.
//  Copyright © 2021 José Mateus Azevedo. All rights reserved.
//

import Foundation

protocol Router {
    var hostname: String { get }
    var url: String? { get }
}
