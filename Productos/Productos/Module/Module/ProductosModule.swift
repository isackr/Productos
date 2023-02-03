//
//  ProductosModule.swift
//  Productos
//
//  Created by Isaac Rosas on 02/02/23.
//

import Foundation
import UIKit

final class ProductosModule {
    let presenter: ProductosPresenter?
    
    init(viewcontroller: UIViewController) {
        let dataManager: ProductosDataManager = ProductosDataManager()
        let interactor: ProductosInteractor = ProductosInteractor(dataManager: dataManager)
        
        let wireframe: ProductosWireframe = ProductosWireframe(viewcontroller: viewcontroller)
        presenter = ProductosPresenter(wireframe: wireframe,
                                       interactor: interactor)
    }
    
    func showProductosModule() {
        guard let presenter = presenter else { return }
        presenter.showProductosModule()
    }
}
