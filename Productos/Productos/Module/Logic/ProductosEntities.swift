//
//  ProductosEntities.swift
//  Productos
//
//  Created by Isaac Rosas on 02/02/23.
//

import Foundation

struct ProductosModel: Decodable {
    let item: Item?
}

struct Item: Decodable {
    let props: Props?
}

struct Props: Decodable {
    let pageProps: PageProps?
}

struct PageProps: Decodable {
    let initialData: InitialData?
}

struct InitialData: Decodable {
    let searchResult: SearchResult?
}

struct SearchResult: Decodable {
    var itemStacks: [ItemStacks] = []
}

struct ItemStacks: Decodable {
    let items: [ItemsStack]?
}

struct ItemsStack: Decodable {
    let image: String?
    let name: String?
    let priceInfo: PriceInfo?
}

struct PriceInfo: Decodable {
    let linePrice: String?
}
