//
//  AppDelegate.swift
//  Reminder
//
//  Created by 유철원 on 7/2/24.
//

import UIKit
import IQKeyboardManagerSwift
import RealmSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.resignOnTouchOutside = true
        
        let config = Realm.Configuration(schemaVersion: 6) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                
            }
            if oldSchemaVersion < 2 {
               
            }
            if oldSchemaVersion < 3 {
               
            }
            if oldSchemaVersion < 4 {
                migration.renameProperty(onType: TodoModel.className(),
                                        from: "isLike", to: "isFlag")
            }
            
            if oldSchemaVersion < 5 {
                
            }
            
            if oldSchemaVersion < 6 {
                
            }
        }
        Realm.Configuration.defaultConfiguration = config
    
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

