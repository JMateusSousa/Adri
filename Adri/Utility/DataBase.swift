//
//  DataBase.swift
//  Adri
//
//  Created by José Mateus Azevedo on 26/08/20.
//  Copyright © 2020 José Mateus Azevedo. All rights reserved.
//

import Foundation

class DataBase {
    
    var fileURL: URL
    
    init(filename: String = "medicine") {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        fileURL = url.appendingPathComponent(filename)
        fileURL = fileURL.appendingPathExtension("json")
        print(fileURL)
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: [:])
        }
    }
    
    func save(medicines: [Medicine]) {
        do {
            let jsonData = try JSONEncoder().encode(medicines)
            FileManager.default.createFile(atPath: fileURL.path, contents: jsonData
                , attributes: [:])
        } catch {
            print(error)
        }
    }
    
    func load() -> [Medicine] {
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let medicines = try JSONDecoder().decode([Medicine].self, from: jsonData)
            return medicines
        } catch {
            print(error)
            return []
        }
        
    }
    
}
