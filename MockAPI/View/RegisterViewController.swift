import UIKit

class RegisterViewController: UIViewController {
    private var viewModel : RegisterViewModelProtocol
    
    fileprivate let errorlabel: UILabel = {
        let label: UILabel = .init(text: "", font: .boldSystemFont(ofSize: 13))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
    }()
    
    fileprivate let emailErrorLabel: UILabel = {
        let label: UILabel = .init(text: .empty, font: .systemFont(ofSize: 10))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
    }()
    
    fileprivate let passwordErrorLabel: UILabel = {
        let label: UILabel = .init(text: .empty, font: .systemFont(ofSize: 10))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
    }()
    
    fileprivate let ageErrorLabel: UILabel = {
        let label: UILabel = .init(text: .empty, font: .systemFont(ofSize: 10))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
    }()
    
    private let emailTextField: UITextField = {
        let field: UITextField = .init(placeholder: "Enter email")
        field.autocapitalizationType = .none
        field.keyboardType = .emailAddress
        return field
    }()
    
    private let passTextField: UITextField = {
        return .init(placeholder: "Super password")
    }()
    
    private let ageField: UITextField = {
        let field: UITextField = .init(placeholder: "Your age")
        field.keyboardType = .numberPad
        return field
    }()
    
    private lazy var registerButton: UIButton = {
        let button: UIButton = .init(title: "Register")
        button.addTarget(self, action: #selector(registerHandler), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: RegisterViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Registration"
        
        viewModel.delegate = self
        layout()
    }
    
    fileprivate var emailErrorLabelHeightConstraint: NSLayoutConstraint = .init()
    fileprivate var passwordErrorLabelHeightConstraint: NSLayoutConstraint = .init()
    fileprivate var ageErrorLabelHeightConstraint: NSLayoutConstraint = .init()
    
    private func layout() {

        setViewSize(targetView: emailTextField, width: 180, height: 30)
        setViewSize(targetView: passTextField, width: 180, height: 30)
        setViewSize(targetView: ageField, width: 180, height: 30)
        
        let verticalStack = VerticalStackView(arrangedSubviews: [
            errorlabel,
            emailTextField,
            emailErrorLabel,
            passTextField,
            passwordErrorLabel,
            ageField,
            ageErrorLabel,
            registerButton
        ], spacing: 10)
        
        verticalStack.alignment = .center
        
        view.addSubview(verticalStack)
        
        emailErrorLabelHeightConstraint = emailErrorLabel.heightAnchor.constraint(equalToConstant: 0)
        passwordErrorLabelHeightConstraint = passwordErrorLabel.heightAnchor.constraint(equalToConstant: 0)
        ageErrorLabelHeightConstraint = ageErrorLabel.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            verticalStack.widthAnchor.constraint(equalTo: view.widthAnchor),
            verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -110),
            emailErrorLabelHeightConstraint,
            passwordErrorLabelHeightConstraint,
            ageErrorLabelHeightConstraint
        ])
    }
    
    @objc private func registerHandler(_ sender: Any) {
        errorlabel.text = .empty
        emailErrorLabelHeightConstraint.constant = 0
        passwordErrorLabelHeightConstraint.constant = 0
        ageErrorLabelHeightConstraint.constant = 0
        
        viewModel.register(email: emailTextField.text, password: passTextField.text, age: ageField.text)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField { emailErrorLabel.text = .empty; emailErrorLabelHeightConstraint.constant = 0 }
        if textField == passTextField { passwordErrorLabel.text = .empty; passwordErrorLabelHeightConstraint.constant = 0 }
        if textField == ageField { ageErrorLabel.text = .empty; ageErrorLabelHeightConstraint.constant = 0 }
        
        errorlabel.text = .empty
        
        return true
    }
}

extension RegisterViewController: ViewControllerDelegate {
    func errorMessage(_ message: InputError) {
        switch message {
            
        case .badEmail:
            emailErrorLabelHeightConstraint.constant = 12
            emailErrorLabel.text = message.description
            
        case .badPassword:
            passwordErrorLabelHeightConstraint.constant = 12
            passwordErrorLabel.text = message.description
            
        case .age:
            ageErrorLabelHeightConstraint.constant = 12
            ageErrorLabel.text = message.description
            
        default:
            errorlabel.text = message.description
        }
    }
}
