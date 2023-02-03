//
//  ProductosWireframe.swift
//  Productos
//
//  Created by Isaac Rosas on 02/02/23.
//

import Foundation
import UIKit

protocol ProductosWireframeProtocol: AnyObject {
    func showProductosModule(presenter: ProductosPresenter)
}

final class ProductosWireframe: ProductosWireframeProtocol {
    let uvc: UIViewController?
   
    init(viewcontroller: UIViewController) {
        uvc = viewcontroller
    }
    
    func showProductosModule(presenter: ProductosPresenter) {
        let vc = ProductosViewController()
        vc.presenter = presenter
        uvc?.present(vc, animated: true)
    }
}
