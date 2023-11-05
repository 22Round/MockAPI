import UIKit

class SuccessViewController: UIViewController {
    
    private let coordinator: CoordinatorProtocol
    
    private let iconView: UIImageView = {
        let imageView: UIImageView = .init(image: UIImage(systemName: "checkmark.circle"))
        imageView.tintColor = .green
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backToLoginButton: UIButton = {
        let button: UIButton = .init(title: "Back to Login")
        button.addTarget(self, action: #selector(backToLoginHandler), for: .touchUpInside)
        return button
    }()
    
    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true

         
        let userLabel = UILabel(text: "You Have Successfully Registered", font: .boldSystemFont(ofSize: 15))
        userLabel.textAlignment = .center
        userLabel.numberOfLines = 0
        userLabel.sizeToFit()
        let stackView = VerticalStackView(arrangedSubviews: [
            iconView,
            userLabel,
            backToLoginButton
            ], spacing: 5)
        
        view.addSubview(stackView)
        iconView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
    }
    
    @objc private func backToLoginHandler() {
        coordinator.popToRoot()
    }

}
