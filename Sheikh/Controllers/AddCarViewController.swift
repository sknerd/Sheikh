//  AddCarViewController.swift
//  Sheikh
//
//  Created by renks on 17/10/2019.
//  Copyright © 2019 Renald Shchetinin. All rights reserved.
//

import UIKit
import RealmSwift

class AddCarViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var carImage: UIButton!
    @IBOutlet weak var carBrand: UITextField!
    @IBOutlet weak var carModel: UITextField!
    @IBOutlet weak var carYear: UITextField!
    @IBOutlet weak var carBodyStyle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPadding()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        saveCar()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //Setting padding for text labels
    
    func setPadding() {
        carBrand.setLeftPaddingPoints(10)
        carModel.setLeftPaddingPoints(10)
        carYear.setLeftPaddingPoints(10)
        carBodyStyle.setLeftPaddingPoints(10)
    }
    
    //Checking text fields for valid and complete info provided by the user
    
    func saveCar() {
        
        let isFormValid = carBrand.text?.isEmpty != true && carBrand.text?.isEmpty != true && carModel.text?.isEmpty != true && carYear.text?.isEmpty != true && carBodyStyle.text?.isEmpty != true && Int(carYear.text!) != nil
        
        if isFormValid {
            let newCar = Car(brand: carBrand.text!, model: carModel.text!, year: Int(carYear.text!)!, bodyStyle: carBodyStyle.text!)
            StorageManager.saveObject(newCar)
            
            let alert = UIAlertController(title: "Saved!", message: "Your new car was added", preferredStyle: .alert)
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
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}
