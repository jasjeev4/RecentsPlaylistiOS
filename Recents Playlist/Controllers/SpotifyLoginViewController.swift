//
//  SpotifyLoginViewController.swift
//  RecentsiOS
//
//  Created by Jasjeev on 5/19/21.
//

import UIKit
import SpotifyLogin

public class SpotifyLoginViewController: UIViewController {
    // MARK: - Properties
    private(set) lazy var loginButton: SpotifyLoginButton? = {
        return SpotifyLoginButton(viewController: self, scopes: SpotifyService.loginScopes)
    }()

    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        if let loginButton = loginButton {
            view.addSubview(loginButton)
        }
    }

    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        loginButton?.center = self.view.center
    }
}
