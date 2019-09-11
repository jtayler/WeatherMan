//
//  SceneDelegate.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import UIKit
import SwiftUI

class MyUIHostingController<Content> : UIHostingController<Content> where Content : View {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        print("previousTraitCollection \(String(describing: previousTraitCollection))")
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("viewWillTransition \(String(describing: size))")
        NotificationCenter.default.post(name: .my_onViewWillTransition, object: nil, userInfo: ["size": size])
        super.viewWillTransition(to: size, with: coordinator)
    }

}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let cityStore = CityStore(isLargeView: true)
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        cityStore.decode()
        
        Location.shared.cityStore = cityStore
        Location.shared.startUpdating()

        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            if let window = window {
                let cityListView = CityList().environmentObject(cityStore)
                window.rootViewController = MyUIHostingController(rootView: cityListView)
                
                let tint = UIColor(hex: "#ffe700ff")
                window.tintColor = tint
                
                window.makeKeyAndVisible()
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

