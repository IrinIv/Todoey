//
//  AppDelegate.swift
//  Todoey
//
//  Created by Irina Ivanushkina on 9/1/19.
//  Copyright © 2019 Irina Ivanushkina. All rights reserved.
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
        } catch {
            print("Error initialazing the new realm, \(error)")
        }
        
        return true
    }

}

