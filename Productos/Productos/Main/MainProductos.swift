//
//  MainProductos.swift
//  Productos
//
//  Created by Isaac Rosas on 03/02/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class MainProductos: UIViewController {
    private let disposeBag = DisposeBag()
    var module: ProductosModule?
    
    @IBOutlet private weak var btnWelcome: UIButton! {
        didSet {
            btnWelcome.accessibilityIdentifier = "BTN_WELCOME"
            btnWelcome.rx
                .tap
                .throttle(.milliseconds(500), latest: false, scheduler: MainScheduler.instance)
                .subscribe(onNext: { [weak self] _ in
                    print("button tapped")
                    self?.timerAction()
                }).disposed(by: disposeBag)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Timer.scheduledTimer(timeInterval: 3.0,
                                 target: self,
                                 selector: #selector(timerAction),
                                 userInfo: nil,
                                 repeats: false)
    }
    //new function
    @objc func timerAction() {
        /*let navVC = UINavigationController(rootViewController: self)
        navVC.didMove(toParent: self)
       // let navigationController = UINavigationController(rootViewController: self)
       //                 self.window?.rootViewController = navigationController
        
        let VC = ProductosViewController(nil)
        self.present(VC, animated: true)
        */
        module = ProductosModule(viewcontroller: self)
        module?.showProductosModule()
    }
    
}
