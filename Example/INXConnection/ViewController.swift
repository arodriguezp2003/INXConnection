//
//  ViewController.swift
//  INXConnection
//
//  Created by Alejandro Rodriguez on 09/23/2020.
//  Copyright (c) 2020 Alejandro Rodriguez. All rights reserved.
//

import UIKit
import INXConnection
struct Employees: Codable {
    let id : Int
    let employee_name: String
    let employee_salary: Int
    let employee_age : Int
    let profile_image : String
    
}

struct POST:Codable {
    let name: String
    let salary: String
    let  age: String
    let  id: Int?
}
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapGET(_ sender: Any) {
        APIManager.shared.setHeader(key: "ARP", value: "calue")
        Mockup().get(uri: "/api/v1/employees")
        APIManager.shared.get(uri: "/employees") { (result: Result<[Employees], APIManagerError>) in
            switch result {
            case .success(let todo):
                print(todo)
            case .failure(let err):
                print(err)
            }
        }
    }
    @IBAction func didTapPOST(_ sender: Any) {
        let params = [
            "name": "test",
            "salary": "123",
            "age": "23"
        ]
        APIManager.shared.post(uri: "/create", params: params) { ( result: Result<POST, APIManagerError>) in
            switch result {
            case .success(let todo):
                print(todo)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    @IBAction func didTapPUT(_ sender: Any) {
        let params = [
            "name": "test",
            "salary": "123",
            "age": "23"
        ]
        APIManager.shared.put(uri: "/update/12", params: params) { ( result: Result<POST, APIManagerError>) in
            switch result {
            case .success(let todo):
                print(todo)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    @IBAction func didTapDelete(_ sender: Any) {
        
        APIManager.shared.delete(uri: "/delete/800") { (result: Result<String, APIManagerError>) in
            switch result {
            case .success(let todo):
                print(todo)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    
}

