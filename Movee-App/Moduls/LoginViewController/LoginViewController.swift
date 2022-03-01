//
//  LoginViewController.swift
//  Movee-App
//
//  Created by Erol, Artun on 13.02.2022.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var loginPageImage: UIImageView!
    @IBOutlet private weak var showPasswordButton: UIButton!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButtonOutlet: UIButton!

    // MARK: - Properties
    private var parameters: [String: Any] = [:]
    private var token: String?

    var viewModel: LoginViewModel?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        requestToken()
        setupViews()
        dissmissLoginVC()
    }

    // MARK: - Private Funcs

    private func requestToken() {
        viewModel?.tokenRequest()
        viewModel?.tokenRequestSucess = { [weak self] requestToken in
            self?.token = requestToken
        }
    }

    private func setupViews() {
        setBackgroundImage()
        loginButtonOutlet.layer.cornerRadius = 4
    }

    private func setBackgroundImage() {
        loginPageImage.autoresizingMask = .flexibleRightMargin
        loginPageImage.contentMode = .scaleAspectFill
        loginPageImage.image = UIImage(named: "loginPageBackground")

        showPasswordButton.titleLabel?.text = ""
    }

    private func dissmissLoginVC() {
        viewModel?.loginRequestSucess = { [weak self] loginSuccess in
            if loginSuccess {
                let tabBar = TabBarBuilder.shared.build()
                self?.navigationController?.pushViewController(tabBar, animated: true)
                // SET the userdefaults value for login inorder to remember the user.
            } else {
                print("Cant Login")
            }
        }
    }

    // MARK: - IBActions

    @IBAction private func loginButtonPressed(_ sender: Any) {
        guard let username = emailTextField.text, let password = passwordTextField.text else { return }
        parameters["username"] = username
        parameters["password"] = password
        parameters["request_token"] = token ?? ""
        viewModel?.loginRequest(with: self.parameters)
    }
}
