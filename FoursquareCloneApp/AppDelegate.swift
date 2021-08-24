//
//  AppDelegate.swift
//  FoursquareCloneApp
//
//  Created by Semih Kalaycı on 24.08.2021.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let configuration = ParseClientConfiguration { ParseMutableClientConfiguration in //parse config ayarları
            // server a bağlanmak için bu 3ünü vermek gerekiyor
            ParseMutableClientConfiguration.applicationId = "aLUxc7P6EkmH0jPaOyO8M62zQyfRt21tpRGZKbRF"
            ParseMutableClientConfiguration.clientKey = "KNAOV86xO0YRUITtBcr8HzGrrLltaFWIg4ljT8Vs"
            ParseMutableClientConfiguration.server = "https://parseapi.back4app.com/"
            
            
        }
        
        Parse.initialize(with: configuration) //initialize et
        
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

