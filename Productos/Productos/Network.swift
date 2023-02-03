//
//  Network.swift
//  Productos
//
//  Created by Isaac Rosas on 02/02/23.
//

import Foundation
import RxSwift
import RxCocoa

final class Network {
    
    func loadData(parameter1: String = "",
                  parameter2: Int = 1) -> Single<ProductosModel?> {
        
        return Single<ProductosModel?>.create { single in
            let urlString: String = "https://00672285.us-south.apigw.appdomain.cloud/demo-gapsi/search?&query=\(parameter1)&page=\(parameter2)"
            guard let url = URL(string: urlString) else {
                return single(.success(nil)) as! Disposable
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("adb8204d-d574-4394-8c1a-53226a40876e", forHTTPHeaderField: "X-IBM-Client-Id")
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                do {
                    if let networkError = error {
                        throw networkError
                    }
                    guard let data = data else {
                        return single(.failure(CustomError.invalidData))
                    }
                    let dataModel = try JSONDecoder().decode(ProductosModel.self, from: data)
                    single(.success(dataModel))
                } catch {
                    return single(.success(nil))
                }
            })
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

enum CustomError: Error {
    // Throw when an invalid password is entered
    case invalidURL

    // Throw when an expected resource is not found
    case invalidData

    // Throw in all other cases
    case unexpected(code: Int)
}
