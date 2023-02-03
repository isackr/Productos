//
//  ViewController.swift
//  Productos
//
//  Created by Isaac Rosas on 02/02/23.
//

import UIKit
import RxSwift
import RxCocoa

class ProductosViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.accessibilityIdentifier = "SEARCH_BAR"
        }
    }
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.accessibilityIdentifier = "TABLEVIEW"
        }
    }
    
    @IBOutlet private weak var btnSearch: UIButton! {
        didSet {
            btnSearch.accessibilityIdentifier = "BUTTON_SEARCH"
        }
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    var presenter: ProductosPresenterProtocol = ProductosPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        btnSearch.rx
            .tap
            .throttle(.milliseconds(500), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                print("button tapped")
                self?.presenter.searchProduct(text: self?.searchBar?.text ?? "")
            }).disposed(by: disposeBag)
        
        
    }
}
