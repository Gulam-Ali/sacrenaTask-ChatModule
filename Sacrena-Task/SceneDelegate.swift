//
//  SceneDelegate.swift
//  Sacrena-Task
//
//  Created by Gulam Ali on 15/09/24.
//

import UIKit
import StreamChat

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let config = ChatClientConfig(apiKey: .init(streamChat.apiKey))
        /// user id and token for the user
        let userId = streamChat.aliceID
        let token: Token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYWxpY2UtOTY1MCJ9.IWZct_53TKi958F8O4Ub5HOn11dZ_qcqo3q9ey1QJS4"

        /// Step 1: create an instance of ChatClient and share it using the singleton
        ChatClient.shared = ChatClient(config: config)

        /// Step 2: connect to chat
        ChatClient.shared.connectUser(
            userInfo: UserInfo(
                id: userId,
                name: "Alice",
                imageURL: URL(string: "https://bit.ly/2TIt8NR")
            ),
            token: token
        ) { error in
            if let error = error {
                print("Connection failed with: \(error)")
            } else {
                // User successfully connected
                print("User successfully connected to Stream")
            }
        }

        //Enable for stream debug logs
        //LogConfig.level = .info
        guard let _ = (scene as? UIWindowScene) else { return }
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


}

