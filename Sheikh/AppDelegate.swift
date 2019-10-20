//
//  AppDelegate.swift
//  Sheikh
//
//  Created by renks on 17/10/2019.
//  Copyright © 2019 Renald Shchetinin. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Uncomment next line to locate Realm Database
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()
        } catch {
            print ("Error initialising new realm, \(error)")
        }
        
        return true
    }
    
}
