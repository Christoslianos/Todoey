//
//  AppDelegate.swift
//  Todoey
//
//  Created by Christos Lianos on 2018-11-09.
//  Copyright © 2018 Christos Lianos. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        do {
           _ = try Realm()
            }
        catch {
            print ("Error initializing new realm, \(error)")
        }
        return true
    }
    



}

    


