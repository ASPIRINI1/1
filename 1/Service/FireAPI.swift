//
//  FireAPI.swift
//  1
//
//  Created by Станислав Зверьков on 19.10.2022.
//

import Foundation
import UIKit
import Firebase

protocol FireAPIProtocol {
    func getProucts(completion: @escaping ([(category: String, products: [Product])]?) -> ())
    func getProducts(fromCollection collection: String, completion: @escaping ([Product]?) -> ())
    func getImage(in collection: String, for id: String, completion: @escaping (UIImage?) -> ())
}

class FireAPI: FireAPIProtocol {
    
    static let shared = FireAPI()
    private var db: Firestore = {
         let settings = FirestoreSettings()
         Firestore.firestore().settings = settings
         return Firestore.firestore()
     }()
    
    enum Collections: String, CaseIterable {
        case products = "Pizza"
        case drinks = "Drinks"
        case desserts = "Desserts"
        case sets = "Sets"
    }
    
    enum DocumentFields: String {
        case title = "title"
        case description = "description"
        case price = "price"
    }
    
    private init() {}
    
    func getProucts(completion: @escaping ([(category: String, products: [Product])]?) -> ()) {
        var allProducts: [(category: String, products: [Product])] = []
        for collection in Collections.allCases {
            getProducts(fromCollection: collection.rawValue) { products in
                guard let products = products else { return }
                allProducts.append((category: collection.rawValue, products: products))
                if allProducts.count == Collections.allCases.count {
                    completion(allProducts)
                }
            }
        }
    }
    
    func getProducts(fromCollection collection: String, completion: @escaping ([Product]?) -> ()) {
        db.collection(collection).getDocuments { querySnapshot, error in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            guard let documents = querySnapshot?.documents else { completion(nil); return }
            var products: [Product] = []
            for document in documents {
                products.append(Product(id: document.documentID,
                                        title: document.get(DocumentFields.title.rawValue) as? String ?? "",
                                        description: document.get(DocumentFields.description.rawValue) as? String ?? "",
                                        price: document.get(DocumentFields.price.rawValue) as? Int ?? 0))
                if products.count == documents.count {
                    completion(products)
                }
            }
        }
    }
    
    func getImage(in collection: String, for id: String, completion: @escaping (UIImage?) -> ()) {
        let reference = Storage.storage().reference().child(collection).child(id)
        reference.listAll { result, error in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            guard let result = result?.items.first else { completion(nil); return }
            result.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error)
                    completion(nil)
                    return
                }
                guard let data = data else { completion(nil); return }
                guard let image = UIImage(data: data) else { completion(nil); return }
                completion(image)
            }
        }
    }
}
