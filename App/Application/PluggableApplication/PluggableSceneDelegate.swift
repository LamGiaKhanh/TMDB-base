//
//  PluggableSceneDelegate.swift
//  StreamApp
//
//  Created by Phat Le on 12/04/2022.
//

import SwiftUI

public protocol SceneService: UIWindowSceneDelegate {}

open class PluggableSceneDelegate: UIResponder, UIWindowSceneDelegate {
    open var services: [SceneService] { return [] }
    private lazy var lazyServices: [SceneService] = {
        self.services
    }()

    @discardableResult
    private func apply<T, S>(_ work: (SceneService, @escaping (T) -> Void) -> S?, completionHandler: @escaping ([T]) -> Swift.Void) -> [S] {
        let dispatchGroup = DispatchGroup()
        var results: [T] = []
        var returns: [S] = []

        for service in lazyServices {
            dispatchGroup.enter()
            let returned = work(service, { result in
                results.append(result)
                dispatchGroup.leave()
            })
            if let returned = returned {
                returns.append(returned)
            } else {
                dispatchGroup.leave()
            }
            if returned == nil {}
        }

        dispatchGroup.notify(queue: .main) {
            completionHandler(results)
        }

        return returns
    }

    open func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        lazyServices.forEach { $0.scene?(scene, willConnectTo: session, options: connectionOptions) }
    }

    open func windowScene(_ windowScene: UIWindowScene, didUpdate previousCoordinateSpace: UICoordinateSpace, interfaceOrientation previousInterfaceOrientation: UIInterfaceOrientation, traitCollection previousTraitCollection: UITraitCollection) {
        lazyServices.forEach { $0.windowScene?(windowScene, didUpdate: previousCoordinateSpace, interfaceOrientation: previousInterfaceOrientation, traitCollection: previousTraitCollection) }
    }

    open func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        apply({ (service, completionHandler) -> Void in
            service.windowScene?(windowScene, performActionFor: shortcutItem) { result in
                completionHandler(result)
            }
        }, completionHandler: { results in
            let result = results.reduce(false, { $0 || $1 })
            completionHandler(result)
        })
    }

    open func sceneDidDisconnect(_ scene: UIScene) {
        lazyServices.forEach { $0.sceneDidDisconnect?(scene) }
    }

    open func sceneDidBecomeActive(_ scene: UIScene) {
        lazyServices.forEach { $0.sceneDidBecomeActive?(scene) }
    }

    open func sceneWillResignActive(_ scene: UIScene) {
        lazyServices.forEach { $0.sceneWillResignActive?(scene) }
    }

    open func sceneWillEnterForeground(_ scene: UIScene) {
        lazyServices.forEach {$0.sceneWillEnterForeground?(scene) }
    }

    open func sceneDidEnterBackground(_ scene: UIScene) {
        lazyServices.forEach { $0.sceneDidEnterBackground?(scene) }
    }

    open func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        lazyServices.forEach { $0.scene?(scene, openURLContexts: URLContexts) }
    }

    open func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        for service in lazyServices {
            if let result = service.stateRestorationActivity?(for: scene) {
                print("[SDOSPluggableApplicationDelegate] - Return first responder of \(#function)")
                return result
            }
        }
        return nil
    }

    open func scene(_ scene: UIScene, willContinueUserActivityWithType userActivityType: String) {
        lazyServices.forEach { $0.scene?(scene, willContinueUserActivityWithType: userActivityType) }
    }

    open func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        lazyServices.forEach { $0.scene?(scene, continue: userActivity) }
    }

    open func scene(_ scene: UIScene, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        lazyServices.forEach { $0.scene?(scene, didFailToContinueUserActivityWithType: userActivityType, error: error) }
    }

    open func scene(_ scene: UIScene, didUpdate userActivity: NSUserActivity) {
        lazyServices.forEach { $0.scene?(scene, didUpdate: userActivity) }
    }
}

extension PluggableApplicationDelegate {
    open func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        for service in lazyServices {
            if let result = service.application?(application, configurationForConnecting: connectingSceneSession, options: options) {
                print("[PluggableApplicationDelegate] - Return first responder of \(#function)")
                return result
            }
        }

        print("[PluggableApplicationDelegate] - Any service implement \(#function). Return a default configuration")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    open func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        lazyServices.forEach { $0.application?(application, didDiscardSceneSessions: sceneSessions) }
    }
}
