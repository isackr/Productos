//
//  ProductosPresenter.swift
//  Productos
//
//  Created by Isaac Rosas on 02/02/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProductosPresenterProtocol: AnyObject {
    func searchProduct(text: String)
    func reloadSearchProduct(text: String, page: Int)
}

final class ProductosPresenter: ProductosPresenterProtocol {
    var interactor: ProductosInteractorProtocol = ProductosInteractor()
    var valuesProductosModel: ProductosModel?
    var disposeBag: DisposeBag = DisposeBag()
    init(){}
    
    func searchProduct(text: String) {
        interactor.searchProduct(text: text)
            .subscribe(onSuccess: { [weak self] productos in
                self?.valuesProductosModel = productos
            }, onFailure: { error in
                print("onError:", error)
            })
            .disposed(by: disposeBag)
    }
    
    func reloadSearchProduct(text: String, page: Int) {
        interactor.searchProduct(text: text)
            .subscribe(onSuccess: { [weak self] productos in
                self?.valuesProductosModel = productos
            }, onFailure: { error in
                print("onError:", error)
            })
            .disposed(by: disposeBag)
    }
}
