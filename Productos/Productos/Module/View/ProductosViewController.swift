//
//  ViewController.swift
//  Productos
//
//  Created by Isaac Rosas on 02/02/23.
//

import UIKit
import RxSwift
import RxCocoa
import SCLAlertView
import MBProgressHUD

final class ProductosViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.accessibilityIdentifier = "SEARCH_BAR"
            searchBar.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet private weak var tableViewProduct: UITableView! {
        didSet {
            tableViewProduct.accessibilityIdentifier = "TABLEVIEW"
            tableViewProduct.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet private weak var btnSearch: UIButton! {
        didSet {
            btnSearch.accessibilityIdentifier = "BUTTON_SEARCH"
            btnSearch.layer.cornerRadius = 10
        }
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    var presenter: ProductosPresenter?
    var arrayProductos: [ItemsStack] = []
    
    init() {
        super.init(nibName: "ProductosViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let nib = UINib(nibName: "ProductosViewController", bundle: nil)
        guard let customView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("Error instantiating CustomView") }
        view.addSubview(customView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        registerTableView()
    }
    
    func registerTableView() {
        tableViewProduct.delegate = self
        tableViewProduct.dataSource = self
        let textFieldCell = UINib(nibName: "ProductosViewControllerCell",
                                  bundle: nil)
        tableViewProduct.register(textFieldCell,
                                  forCellReuseIdentifier: "cell")
    }
    
    func bind() {
        btnSearch.rx
            .tap
            .throttle(.milliseconds(500), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.showHud()
                self?.presenter?.searchProduct(text: self?.searchBar?.text ?? "")
            }).disposed(by: disposeBag)
        
        presenter?
            .showProgress
            .subscribe(onNext: { [weak self] show in
                show == true ? self?.showHud() : self?.hideHud()
            }).disposed(by: disposeBag)
        
        presenter?
            .arrayProductos
            .subscribe(onNext: { [weak self] arrayProds in
                self?.arrayProductos = arrayProds
                self?.reloadData()
            }).disposed(by: disposeBag)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableViewProduct.reloadData()
        }
    }
    
    func showHud() {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    func hideHud() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}

extension ProductosViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayProductos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ProductosViewControllerCell {
            if let item = arrayProductos[safe: indexPath.row] {
                cell.setup(product: item)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "LISTA DE PRODUCTOS"
    }
}

public extension MutableCollection {
    subscript(safe index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set(newValue) {
            if let newValue = newValue, indices.contains(index) {
                self[index] = newValue
            }
        }
    }
}
