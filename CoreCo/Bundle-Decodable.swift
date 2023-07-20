//
//  Bundle-Decodable.swift
//  CoreCo
//
//  Created by roger deutsch on 7/18/23.
//

import Foundation

extension Bundle{
    func decode<T: Decodable>(_ file: String) -> T{
        guard let url = self.url(forResource: file, withExtension: "json") else{
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Failed to load \(file) from bundle.")
        }
        print("data: \(data)")
        
        let decoder = JSONDecoder()
        
        do {
            let loadedData = try decoder.decode(T.self, from: data)
            return loadedData
        }catch {
            fatalError(error.localizedDescription)
        }
    }
}
