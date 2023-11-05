import Foundation
import APIService

protocol RegisterViewModelProtocol: ViewModelProtocol {
    func register( email: String?, password: String?, age: String?)
}

class RegisterViewModel: RegisterViewModelProtocol {
    private let coordinator : CoordinatorProtocol
    private let service: APIServieProtocol
    weak var delegate: ViewControllerDelegate?
    
    required init(coordinator: CoordinatorProtocol, service: APIServieProtocol) {
        self.coordinator = coordinator
        self.service = service
    }
    
    @MainActor
    func register(email: String?, password: String?, age: String?) {
        
        guard let email = email?.lowercased(), let pass = password, let age = age else { return }
        
        if !email.isValidEmail {
            delegate?.errorMessage(.badEmail)
            return
        }
        
        if !pass.isValidPassword {
            delegate?.errorMessage(.badPassword)
            return
        }
        
        if !age.isValidAge {
            delegate?.errorMessage(.age)
            return
        }
        
        Task {
            
            let result = await service.register(.init(id: .init(), email: email, password: pass, age: age))
            switch result {
            case .success( _):
                coordinator.success()
            case .failure(let error):
                delegate?.errorMessage(.common(error.description))
            }
        }
    }
}
