//
//  DetaisViewController.swift
//  Sheikh
//
//  Created by renks on 17/10/2019.
//  Copyright © 2019 Renald Shchetinin. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var currentCar: Car!
    
    @IBOutlet weak var carBrand: UITextField!
    @IBOutlet weak var carModel: UITextField!
    @IBOutlet weak var carBodyStyle: UITextField!
    @IBOutlet weak var carYear: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        setPadding()
        
    }
    
    func setupScreen() {
        carBrand?.text = currentCar.brand
        carModel.text = currentCar.model
        carBodyStyle.text = currentCar.bodyStyle
        carYear.text = String(currentCar.year)
    }
    
    func setPadding() {
        carBrand.setLeftPaddingPoints(10)
        carModel.setLeftPaddingPoints(10)
        carYear.setLeftPaddingPoints(10)
        carBodyStyle.setLeftPaddingPoints(10)
    }
    
    func saveCar() {
        
        let isFormValid = carBrand.text?.isEmpty != true && carBrand.text?.isEmpty != true && carModel.text?.isEmpty != true && carYear.text?.isEmpty != true && carBodyStyle.text?.isEmpty != true && Int(carYear.text!) != nil
        
        if isFormValid {
            
            try! realm.write {
                currentCar?.brand = carBrand.text!
                currentCar?.model = carModel.text!
                currentCar?.year = Int(carYear.text!)!
                currentCar?.bodyStyle = carBodyStyle.text!
            }
            
            let alert = UIAlertController(title: "Success!", message: "Your car info was updated", preferredStyle: .alert)
            let action = UIAlertAction(title: "Great", style: .default) { (UIAlertAction) in
                self.performSegue(withIdentifier: "unwindToMain", sender: self)
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
            
        } else {
            let alert = UIAlertController(title: "Not enought data", message: "Please fill in all fields", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .cancel)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        saveCar()
        
    }
}
