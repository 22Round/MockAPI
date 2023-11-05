import Foundation
import APIService

protocol ViewModelProtocol: AnyObject {
    var delegate: ViewControllerDelegate? { get set }
    init(coordinator: CoordinatorProtocol, service: APIServieProtocol)
}

protocol LoginViewModelProtocol: ViewModelProtocol {
    func goToRegister()
    func login(email: String?, pass: String?)
}

class LoginViewModel: LoginViewModelProtocol {
    private let coordinator: CoordinatorProtocol
    private var service: APIServieProtocol
    weak var delegate: ViewControllerDelegate?
    
    required init(coordinator: CoordinatorProtocol, service: APIServieProtocol) {
        self.coordinator = coordinator
        self.service = service
    }
    
    func goToRegister() {
        coordinator.register()
    }
    
    @MainActor
    func login(email: String?, pass: String?) {
        
        guard let email = email?.lowercased(), let pass = pass else {
            delegate?.errorMessage(.common(InputError.unknown.description))
            return
        }
        
        if !email.isValidEmail {
            delegate?.errorMessage(.badEmail)
            return
        }
        
        if !pass.isValidPassword {
            delegate?.errorMessage(.badPassword)
            return
        }
        
        Task {
            
            let auth = APIAuthRequestModel(email: email, password: pass)
            let result = await service.auth(auth)
            switch result {
            case .success( _):
                coordinator.list()
            case .failure(let error):
                delegate?.errorMessage(.common(error.description))
            }
        }
    }
}
