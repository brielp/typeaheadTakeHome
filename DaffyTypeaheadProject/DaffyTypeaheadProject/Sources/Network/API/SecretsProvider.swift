//
//  SecretsProvider.swift
//  DaffyTypeaheadProject
//
//  Created by Brielle Petrie on 12/20/22.
//

import Foundation

struct Secrets: Codable {
    let apiKey: String
}

/// Class to extract keys from JSON file
class SecretsProvider {
    func getAPIKey() -> String {
        if let data = readLocalFile() {
            let string = parse(jsonData: data)
            return string ?? ""
        }
        print("Data was empty")
        return ""
    }
    
    private func readLocalFile() -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: "secrets",
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("Error reading secrets.json file", error)
        }
        return nil
    }
    
    private func parse(jsonData: Data) -> String? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(Secrets.self,
                                                       from: jsonData)
            
            return decodedData.apiKey
        } catch {
            print("decode error")
            return nil
        }
    }
}
