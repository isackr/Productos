//
//  ProductosDataManager.swift
//  Productos
//
//  Created by Isaac Rosas on 02/02/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProductosDataManagerProtocol: AnyObject {
    func searchProduct(text: String) -> Single<ProductosModel?>
    func reloadSearchProduct(text: String, page: Int) -> Single<ProductosModel?>
}

final class ProductosDataManager: ProductosDataManagerProtocol {
    var network: Network = Network()
    var disposeBag: DisposeBag = DisposeBag()
    
    init(){}
    
    func searchProduct(text: String) -> Single<ProductosModel?> {
        
        return network
            .loadData(parameter1: text, parameter2: 1)
        
    }
    
    func reloadSearchProduct(text: String, page: Int)  -> Single<ProductosModel?> {
        return network
            .loadData(parameter1: text, parameter2: page)
    }
}
