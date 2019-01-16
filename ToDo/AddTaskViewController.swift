//
//  AddTaskViewController.swift
//  ToDo
//
//  Created by Simon Mc Neil on 2018-01-11.
//  Copyright © 2018 Simon Mc Neil. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var isImp: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //make sure you build to use the core data, after you created it
    @IBAction func btnTapped(_ sender: Any) {

        //always need this line when working with core data
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //now we have an objcet referencing to the entity, and gets are table attributes in the entity we created in the todo.xcdatamodel
        let task = Task(context: context)
        task.name = textField.text!
        task.isimportant = isImp.isOn
        
        //save the data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
}
