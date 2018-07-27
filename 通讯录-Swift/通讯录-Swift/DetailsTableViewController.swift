//
//  DetailsTableViewController.swift
//  通讯录-Swift
//
//  Created by yangfan on 2017/12/26.
//  Copyright © 2017年 yangfan. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var address: UITextField!
    
    
    var person:Person?
    
    var completionCallBack:(()->())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        
        if person == nil {
            
            title = "增加"
            
        }
        

    }
    
    
    private func setupData(){
    
        if let person = person{
    
            name.text = person.name
            phone.text = person.phone
            address.text = person.address
            
        }
    
    }
    
    
    @IBAction func savePerson(_ sender: Any) {
        
        
        //如果是增加，那么需要新建一个Person
        if person == nil {
        
            person = Person()
        
        }
        
        
        person?.name = name.text
        person?.phone = phone.text
        person?.address = address.text
        
        
        //？如果闭包为nil 什么也不做
        completionCallBack?()
        
        
        //_忽略警告
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    

}
