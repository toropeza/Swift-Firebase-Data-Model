//
//  AppDelegate.swift
//  FirebaseTutorial
//
//  Created by Thomas Oropeza on 11/10/16.
//  Copyright © 2016 Thomas Oropeza. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var dataModel = FirebaseDataModel()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }


}

