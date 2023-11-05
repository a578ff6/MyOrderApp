//
//  SceneDelegate.swift
//  MyOrderApp
//
//  Created by 曹家瑋 on 2023/11/3.
//

import UIKit

// 主要的場景代理(SceneDelegate)類別，負責處理窗口場景的生命週期事件。
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    // orderTabBarItem 的參照，用於更新 badge。
    var orderTabBarItem: UITabBarItem!
    
    // 當場景與 App 連接時，這個方法會被呼叫。
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 確保場景是一個窗口場景。
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // 註冊觀察者，以便在訂單更新時收到通知。
        NotificationCenter.default.addObserver(self, selector: #selector(updateOrderBadge), name: MenuController.orderUpdatedNotification, object: nil)
        
        // 初始化orderTabBarItem，指向 TabBarController 中的第二個視圖控制器的頁籤（也就是訂單）。
        orderTabBarItem = (window?.rootViewController as? UITabBarController)?.viewControllers?[1].tabBarItem
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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

    // 更新訂單badge的方法
    @objc func updateOrderBadge() {
        // 設定 badgeValue 為訂單中項目的數量。當當計數為 0 時，將 badge 值設為nil）
        switch MenuController.shared.order.menuItems.count {
        case 0:
            orderTabBarItem.badgeValue = nil
        case let count:
            orderTabBarItem.badgeValue = String(count)
        }
    }

}

