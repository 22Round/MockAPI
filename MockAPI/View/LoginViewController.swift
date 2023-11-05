import UIKit
import APIService

protocol ViewControllerDelegate: AnyObject {
    func errorMessage(_ message: InputError)
    func reload(_ data: [CollectionDataModel])
}

extension ViewControllerDelegate {
    func errorMessage(_ message: InputError) {}
    func reload(_ data: [CollectionDataModel]) {}
}

class LoginViewController : UIViewController {
    private let viewModel: LoginViewModelProtocol
    
    fileprivate let errorlabel: UILabel = {
        let label: UILabel = .init(text: "", font: .boldSystemFont(ofSize: 13))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
    }()
    
    fileprivate let emailErrorLabel: UILabel = {
        let label: UILabel = .init(text: "", font: .systemFont(ofSize: 10))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
    }()
    
    fileprivate let passwordErrorLabel: UILabel = {
        let label: UILabel = .init(text: "", font: .systemFont(ofSize: 10))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
    }()
    
    fileprivate lazy var emailTextField: UITextField = {
        let field: UITextField = .init(placeholder: "Enter email")
        field.autocapitalizationType = .none
        field.keyboardType = .emailAddress
        field.delegate = self
        return field
    }()
    
    fileprivate lazy var passTextField: UITextField = {
        let field: UITextField = .init(placeholder: "Enter password")
        field.delegate = self
        return field
    }()
    
    private lazy var registerButton: UIButton = {
        let button: UIButton = .init(title: "Register")
        button.addTarget(self, action: #selector(registerHandler), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button: UIButton = .init(title: "Login")
        button.addTarget(self, action: #selector(loginHandler), for: .touchUpInside)
        return button
    }()
    
    fileprivate var emailErrorLabelHeightConstraint: NSLayoutConstraint = .init()
    fileprivate var passwordErrorLabelHeightConstraint: NSLayoutConstraint = .init()
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Authorization"
        
        viewModel.delegate = self
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc private func registerHandler() {
        viewModel.goToRegister()
    }
    
    @objc private func loginHandler() {
        emailErrorLabelHeightConstraint.constant = 0
        passwordErrorLabelHeightConstraint.constant = 0
        errorlabel.text = .empty
        viewModel.login(email: emailTextField.text, pass: passTextField.text)
    }
    
    private func layout() {
        setViewSize(targetView: emailTextField, width: 180, height: 30)
        setViewSize(targetView: passTextField, width: 180, height: 30)
        
        let verticalStack = VerticalStackView(arrangedSubviews: [
            errorlabel,
            emailTextField,
            emailErrorLabel,
            passTextField,
            passwordErrorLabel
        ], spacing: 10)
        
        verticalStack.alignment = .center
        
        let horizontalStack = HorizontalStackView(arrangedSubviews: [
            registerButton,
            loginButton
        ], spacing: 10)
        
        view.addSubview(verticalStack)
        view.addSubview(horizontalStack)
        
        emailErrorLabelHeightConstraint = emailErrorLabel.heightAnchor.constraint(equalToConstant: 0)
        passwordErrorLabelHeightConstraint = passwordErrorLabel.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            verticalStack.widthAnchor.constraint(equalTo: view.widthAnchor),
            verticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            horizontalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalStack.topAnchor.constraint(equalTo: verticalStack.bottomAnchor),
            emailErrorLabelHeightConstraint,
            passwordErrorLabelHeightConstraint
        ])
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField { emailErrorLabel.text = .empty; emailErrorLabelHeightConstraint.constant = 0 }
        if textField == passTextField { passwordErrorLabel.text = .empty; passwordErrorLabelHeightConstraint.constant = 0 }
        
        errorlabel.text = .empty
        
        return true
    }
}

extension LoginViewController: ViewControllerDelegate {
    func errorMessage(_ message: InputError) {
        switch message {
        case .badEmail:
            emailErrorLabelHeightConstraint.constant = 12
            emailErrorLabel.text = message.description
        case .badPassword:
            passwordErrorLabelHeightConstraint.constant = 12
            passwordErrorLabel.text = message.description
        default:
            errorlabel.text = message.description
        }
    }
}

