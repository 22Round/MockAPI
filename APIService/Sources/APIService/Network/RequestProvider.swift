import Foundation

protocol RequestProviderProtocol {
  var urlRequest: URLRequest? { get }
}

class RequestProvider: RequestProviderProtocol {
    
    private let serverUrl: String
    init(service: EndPoints){
        serverUrl = service.description
    }
    
    var urlRequest: URLRequest? {
        guard let url: URL = .init(string: serverUrl) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}

extension RequestProvider {
    enum EndPoints {
        case search(String)
        
        var description: String {
            switch self {
            case .search(let search): return "\(Constants.baseURL)?key=\(Constants.key)&q=\(search)&image_type=photo&pretty=true"
            }
        }
    }
}
