//
//  NetworkService.swift
//  TestTask
//
//  Created by Евгений Ефимов on 21.08.2022.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol: AnyObject {
    var dataJSON: Welcome? { get }
    func testGetData() -> Welcome?
//    var testModel: Welcome { get }
//    func dataJSON(_ url: String, _ model: ) ->
}

 class NetworkService: NetworkServiceProtocol {
    
    var dataJSON: Welcome? {
        AF.request("https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175").responseJSON { responseJSON in

            guard let statusCode = responseJSON.response?.statusCode else { return }
            print("statusCode: ", statusCode)

//            if (200..<300).contains(statusCode) {
//                let value = responseJSON.result
//                print("value: ", value ?? "nil")
//            } else {
//                print("error")
//            }
        }
        
        
        
        
//        return nil
        var welcomeData: Welcome!
        let urlString = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
        guard let url = URL(string: urlString) else { return nil }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
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
    
     func testGetData() -> Welcome? {
                 return nil
//                 var welcomeData: Welcome!
//                 let urlString = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
//                 guard let url = URL(string: urlString) else { return nil }
//
//                 URLSession.shared.dataTask(with: url) { data, response, error in
//                     guard let data = data else { return }
//                     guard error == nil else { return }
//
//                     do {
//                         let mainData = try JSONDecoder().decode(Welcome.self, from: data)
//                         welcomeData = mainData
//                     } catch let error {
//                         print(error)
//                     }
//                 }.resume()
//                 return welcomeData
             }
//    var testModel: Welcome {
//        }
    
}
