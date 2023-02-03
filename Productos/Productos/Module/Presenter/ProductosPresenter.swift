//
//  ProductosPresenter.swift
//  Productos
//
//  Created by Isaac Rosas on 02/02/23.
//

import Foundation
import RxSwift
import RxCocoa
import MBProgressHUD

protocol ProductosPresenterProtocol: AnyObject {
    func searchProduct(text: String)
    func reloadSearchProduct(text: String, page: Int)
}

final class ProductosPresenter: ProductosPresenterProtocol {
    var wireframe: ProductosWireframe?
    var interactor: ProductosInteractorProtocol?
    var showProgress = PublishSubject<Bool>()
    var arrayProductos = PublishSubject<[ItemsStack]>()
    
    var valuesProductosModel: ProductosModel?
    var disposeBag: DisposeBag = DisposeBag()
    
    init(wireframe: ProductosWireframe, interactor: ProductosInteractor){
        self.wireframe = wireframe
        self.interactor = interactor
    }
    
    func showProductosModule() {
        wireframe?.showProductosModule(presenter: self)
    }
    
    func searchProduct(text: String) {
        interactor?.searchProduct(text: text)
            .subscribe(onSuccess: { [weak self] productos in
                guard let self = self else { return }
                self.showProgress.onNext(false)
                let arrayItems = productos?
                    .item?
                    .props?
                    .pageProps?
                    .initialData?
                    .searchResult?
                    .itemStacks[safe: 0]?
                    .items
                self.arrayProductos.onNext(arrayItems ?? [])
                self.valuesProductosModel = productos
            }, onFailure: { error in
                self.showProgress.onNext(false)
                print("onError:", error)
            })
            .disposed(by: disposeBag)
    }
    
    func reloadSearchProduct(text: String, page: Int) {
        interactor?.searchProduct(text: text)
            .subscribe(onSuccess: { [weak self] productos in
                self?.showProgress.onNext(false)
                self?.valuesProductosModel = productos
            }, onFailure: { error in
                self.showProgress.onNext(false)
                print("onError:", error)
            })
            .disposed(by: disposeBag)
    }
}
