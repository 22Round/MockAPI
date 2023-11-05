import UIKit
import APIService

class AppCoordinator : CoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    private let service: APIService = .init()
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }

    func login() {
        let viewModel: LoginViewModel = .init(coordinator: self, service: service)
        let viewController = LoginViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    func register() {
        let viewModel: RegisterViewModel = .init(coordinator: self, service: service)
        let viewController = RegisterViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func list() {
        let viewModel: ListViewModel = .init(coordinator: self, service: service)
        let viewController = ListViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func details(model: CollectionDataModel) {
        let viewController = DetailViewController(model: model)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func success() {
        let viewController = SuccessViewController(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    deinit {
        print("deinited")
    }
}

protocol CoordinatorProtocol {
    
    var navigationController : UINavigationController { get set }
    
    func login()
    func register()
    func list()
    func details(model: CollectionDataModel)
    func popToRoot()
    func success()
}
