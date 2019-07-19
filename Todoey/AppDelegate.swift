//
//  AppDelegate.swift
//  Todoey
//
//  Created by Sheheryar Ahmed on 02/07/2019.
//  Copyright © 2019 Mac Dev. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
   
        do{
            _=try Realm()
          
        }
        catch{
            print("Error in realm initializing \(error)")
        }
        
        
        
        
        
        return true
    }

}
