

enum APIManagerServiceError {
    case INVALID_RESPONSE
    case ENCODE_ERROR
    case DECODE_ERROR
    case AUTH
    case NO_PARAMS
    case ERROR_URL
    case NO_PAYLOAD
    case BACKEND_ERROR
}

public struct APIManagerError: Error {
    let error: APIManagerServiceError
    let message: String
    let statusCode: String
    
    init(_ error: APIManagerServiceError, _ statusCode: String = "-1") {
        self.error = error
        self.message = ""
        self.statusCode = statusCode
    }
    
    init(_ error: APIManagerServiceError, message: String, _ statusCode: String = "-1") {
        self.error = error
        self.message = message
        self.statusCode = statusCode
    }
}


public struct APIResponse<T:Decodable>: Decodable {
    let result: String
    let message: String
    let payload: T?
}

public protocol APIMannagerProtocol {
    /// Configura API MANAGER IONIX FORMAT
    /// - Parameter URLBase: example: http://project.com/api/v1
    func configure(_ URLBase: String, resultCode: String)
    
    /// Configura API MANAGER Another server
    /// - Parameter URLBase: W
    func configure(_ URLBase: String)
    /// GET 
    /// - Parameters:
    ///   - uri: endpoint url
    ///   - completion: Result<generic payload, APIManagerError get only errors>
    func get<T:Codable>(uri:String, completion: @escaping (Result<T,APIManagerError>) -> ())
//    func post<T:Codable>(uri:String, params: [String: Any] completion: @escaping (Result<T,APIManagerError>) -> ())
}

public class APIManager: APIMannagerProtocol {
    public static let shared: APIMannagerProtocol = APIManager()
    
    var BASE = ""
    var SUCCESSRESULTCODE = ""
    var ionixServer = false
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    public func configure(_ URLBase: String, resultCode: String) {
        self.BASE = URLBase
        self.SUCCESSRESULTCODE = resultCode
        self.ionixServer = true
    }
    public func configure(_ URLBase: String) {
        self.BASE = URLBase
        self.ionixServer = false
    }
    
    public func get<T:Codable>(uri:String, completion: @escaping (Result<T,APIManagerError>) -> ()) {
        self.dataTask?.cancel()
        
        guard let url = URL(string: "\(self.BASE)\(uri)") else {
            return completion(.failure(.init(.ERROR_URL)))
        }
        
        let request = URLRequest(url: url)
        
        self.request(request: request,  completion: completion)
        
    }
}

extension APIManager {
    func request<T:Codable>(request: URLRequest, completion: @escaping (Result<T,APIManagerError>) -> ()) {
        
        DispatchQueue.global(qos: .utility).async {
            URLSession.shared.dataTask(with: request) { data, response, error in
                let statusCode = "\((response as? HTTPURLResponse)?.statusCode ?? 500)"
                DispatchQueue.main.async {
                    guard let data = data else {
                        completion(.failure(.init(.BACKEND_ERROR, statusCode)))
                        return
                    }
                    
                  
                    if self.ionixServer {
                        guard let decode =  try? JSONDecoder().decode(APIResponse<T>.self, from: data) else {
                            completion(.failure(.init(.DECODE_ERROR, statusCode)))
                            return
                        }
                    
                        guard let payload  = decode.payload else {
                            completion(.failure(.init(.NO_PAYLOAD, statusCode)))
                            return
                        }
                        
                        if decode.result == self.SUCCESSRESULTCODE {
                            completion(.success(payload))
                        } else {
                            completion(.failure(.init(.INVALID_RESPONSE, message: decode.message, statusCode)))
                        }
                    } else {
                        guard let decode =  try? JSONDecoder().decode(T.self, from: data) else {
                            completion(.failure(.init(.DECODE_ERROR, statusCode)))
                            return
                        }
                        completion(.success(decode))
                    }
                }
            }.resume()
        }
    }
}
