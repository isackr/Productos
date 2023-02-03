//
//  ProductosViewControllerCell.swift
//  Productos
//
//  Created by Isaac Rosas on 03/02/23.
//

import Foundation
import UIKit

class ProductosViewControllerCell: UITableViewCell {
    @IBOutlet private weak var productImage: UIImageView! {
        didSet{
            productImage.accessibilityIdentifier = "IMAGE_PRODUCT"
            productImage.contentMode = .scaleAspectFit
            productImage.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet private weak var productName: UILabel! {
        didSet {
            productName.accessibilityIdentifier = "PRUDUCT_NAME"
        }
    }
   
    @IBOutlet private weak var productPrice: UILabel! {
        didSet {
            productPrice.accessibilityIdentifier = "PRUDUCT_PRICE"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
    }
    
    func setup(product: ItemsStack) {
        productName.text = product.name
        productPrice.text = product.priceInfo?.linePrice
        if let imageUrl = product.image {
            let url = URL(string: imageUrl) ?? URL(fileURLWithPath: "")
            downloadImage(from: url)
        }
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.productImage.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
