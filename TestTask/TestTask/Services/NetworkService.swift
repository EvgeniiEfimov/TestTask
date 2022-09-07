//
//  NetworkService.swift
//  TestTask
//
//  Created by Евгений Ефимов on 21.08.2022.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func requestAndParsJSON(complition: @escaping (Welcome, [Data]?, [Data]?) -> Void)
    func brandsNamesArray(_ json: Welcome) -> [String]
}

class NetworkService: NetworkServiceProtocol {
   
    var interactor: MainInteractorProtocol!
        
    func requestAndParsJSON(complition: @escaping (Welcome, [Data]?, [Data]?) -> Void) {
        let urlString = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            guard error == nil else { return }

            do {
                let mainData = try JSONDecoder().decode(Welcome.self, from: data)
                
                 let data = self.parsImage(mainData)
//                self.interactor.networkResponse(mainData)
                complition(mainData, data.0, data.1)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func parsImage(_ json: Welcome) -> ([Data]?,[Data]?) {
        var arrayBestSeller = [Data]()
        var arrayhomwStore = [Data]()
        for image in json.bestSeller {
            guard let url = URL(string: image.picture) else { break }
            guard let data = try? Data(contentsOf: url) else { break }
            arrayBestSeller.append(data)
        }
        print(arrayBestSeller)
        
        for image in json.homeStore {
            guard let url = URL(string: image.picture) else { break }
            guard let data = try? Data(contentsOf: url) else { break }
            arrayhomwStore.append(data)
        }
        return (arrayhomwStore, arrayBestSeller)
    }
    
    func brandsNamesArray(_ json: Welcome) -> [String] {
        var arrayNameBrands = [String]()
        for nameBrand in json.bestSeller {
            arrayNameBrands.append(nameBrand.title)
        }
        return arrayNameBrands
    }
}

