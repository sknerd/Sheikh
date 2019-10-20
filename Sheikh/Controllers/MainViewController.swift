//
//  MainViewController.swift
//  Sheikh
//
//  Created by renks on 17/10/2019.
//  Copyright © 2019 Renald Shchetinin. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {
    
    private var cars: Results<Car>!
    
    let realm = try! Realm()
    
    //Some dummy cars for the first app launch
    
    let dummyCar1 = Car(brand: "Porsche", model: "911", year: 1972, bodyStyle: "Coupe")
    let dummyCar2 = Car(brand: "Ferrari", model: "246 GTS", year: 1973, bodyStyle: "Coupe")
    let dummyCar3 = Car(brand: "Jaguar", model: "XK-E S2", year: 1971, bodyStyle: "Coupe")
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        onFirstLaunch()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        cars = realm.objects(Car.self)
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    
    // MARK: - Cell Setup
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarItemCell", for: indexPath) as! CustomTableViewCell
        
        cell.brandLabel?.text = cars[indexPath.row].brand
        cell.modelLabel.text = cars[indexPath.row].model
        cell.bodyStyleLabel.text = cars[indexPath.row].bodyStyle
        cell.yearLabel.text = String(cars[indexPath.row].year)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(123)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - Deleting Cells
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let car = cars[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            
            StorageManager.deleteObject(car)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return [deleteAction]
    }
    
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetailSegue" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let car = cars[indexPath.row]
            
            let destVC = segue.destination as! DetailsViewController
            
            destVC.currentCar = car
            
        } else {
            return
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        tableView.reloadData()
        
    }
    
    //Detecting app's first launch
    
    func onFirstLaunch(){
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            return
        }
        else {
            print("First launch, setting NSUserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            loadDummyCars()
        }
    }
    
    
    //Loading dummy cars in case of firsl launch app
    
    func loadDummyCars() {
        
        let dummyArray = [dummyCar1, dummyCar2, dummyCar3]
        
        if realm.objects(Car.self).isEmpty {
            for dummy in dummyArray {
                StorageManager.saveObject(dummy)
            }
        }
    }
}
