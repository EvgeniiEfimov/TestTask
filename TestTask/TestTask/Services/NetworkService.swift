//
//  NetworkService.swift
//  TestTask
//
//  Created by Евгений Ефимов on 21.08.2022.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    var dataJSON: Welcome? { get }
//    func dataJSON(_ url: String, _ model: ) ->
}

final class NetworkService: NetworkServiceProtocol {
    
    var dataJSON: Welcome? {
        var welcomeData: Welcome?
        let urlString = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
        guard let url = URL(string: urlString) else { return nil }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let mainData = try JSONDecoder().decode(Welcome.self, from: data)
                welcomeData = mainData
            } catch let error {
                print(error)
            }
        }.resume()
        return welcomeData
    }
    
    
}
