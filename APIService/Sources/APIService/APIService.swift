import Foundation

public protocol APIServieProtocol {
    func register(_ model: APIRegisterRequestModel) async -> Result<Bool, StorageError>
    func auth(_ model: APIAuthRequestModel) async -> Result<APIAuthResponseModel, StorageError>
    func searchPhoto(_ search: String) async -> Result<APISearchRequestModel, ResultError>
    func deleteStorage() async -> Result<Bool, StorageError>
}

public class APIService: APIServieProtocol {
    private let storageName: String = "storage.json"
    private let networkSetvice: NetworkService = .init()
    private let storage: StorageService = .init()
    
    public init() {}
    
    public func register(_ model: APIRegisterRequestModel) async -> Result<Bool, StorageError> {
        
        var storage: [APIRegisterRequestModel]? = try? await self.storage.read(filename: storageName)

        do {
            if storage != nil {
                guard storage?.filter({ $0.email == model.email }).first == nil else { return .failure(.userAlreadyExist) }
            } else {
                storage = []
            }
            storage?.append(model)
            try await self.storage.write(array: storage, filename: storageName)
            return .success(true)
        } catch {
            return .failure(.write)
        }
    }
    
    public func auth(_ model: APIAuthRequestModel) async -> Result<APIAuthResponseModel, StorageError> {
        do {
            guard let storage: [APIRegisterRequestModel] = try await storage.read(filename: storageName), !storage.isEmpty else { return .failure(.read) }
            
            guard let user = storage.filter({ $0.email == model.email }).first else {return .failure(.userNotRegistered)}
            guard user.password == model.password else { return .failure(.wrongPassword) }
            return .success(APIAuthResponseModel(email: user.email, age: user.age))
            
        } catch {
            return .failure(.read)
        }
    }
    
    public func searchPhoto(_ search: String) async -> Result<APISearchRequestModel, ResultError> {
        let request: RequestProviderProtocol = RequestProvider(service: .search(search))
        
        do {
            let result = try await fetch(type: APISearchRequestModel.self, request: request)
            return .success(result)
            
        } catch (let error) {
            return .failure((error as? ResultError) ?? .unknown)
        }
    }
    
    public func deleteStorage() async -> Result<Bool, StorageError> {
        
        do {
            try await storage.delete(filename: storageName)
            return .success(true)
            
        } catch {
            return .failure(.delete)
        }
    }
    
    private func fetch<T: Decodable>(type: T.Type, request: RequestProviderProtocol) async throws -> T {
        let result = await networkSetvice.fetchData(request: request)
        switch result {
        case .success(let dataLoaded):
            let parsedResult = await Parser().parseJSON(json: dataLoaded, type: T.self)
            switch parsedResult {
            case .success(let parserResult):
                return parserResult
                
            case .failure(let parseError):
                throw parseError
            }
        case .failure( let error):
            throw error
        }
    }
}
