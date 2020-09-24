//
//  ViewController.swift
//  INXConnection
//
//  Created by Alejandro Rodriguez on 09/23/2020.
//  Copyright (c) 2020 Alejandro Rodriguez. All rights reserved.
//

import UIKit
import INXConnection

struct Todo: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.shared.configure("https://jsonplaceholder.typicode.com")
   
        APIManager.shared.get(uri: "/todos/1") { (result: Result<Todo, APIManagerError>) in
            switch result {
            case .success(let todo):
                print(todo)
            case .failure(let err):
                print(err)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

