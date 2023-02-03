//
//  ProductosInteractor.swift
//  Productos
//
//  Created by Isaac Rosas on 02/02/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProductosInteractorProtocol: AnyObject {
    func searchProduct(text: String) -> Single<ProductosModel?>
    func reloadSearchProduct(text: String, page: Int) -> Single<ProductosModel?>
}

final class ProductosInteractor: ProductosInteractorProtocol {
    var dataManager: ProductosDataManagerProtocol = ProductosDataManager()
    
    init(){}
    
    func searchProduct(text: String) -> Single<ProductosModel?> {
        return dataManager.searchProduct(text: text)
    }
    
    func reloadSearchProduct(text: String, page: Int) -> Single<ProductosModel?> {
        return dataManager.reloadSearchProduct(text: text, page: page)
    }
}
