

public protocol APIMannagerProtocol {
    /// Configuración para proyectos ionix
    /// - Parameters:
    ///   - URLBase: url base del backend
    ///   - resultCode: String que reponde el servicio cuando esta ok "success" "ok"
    func configure(_ URLBase: String, resultCode: String)
    
    /// Confuguración para proyectos externos a ionix
    /// - Parameter URLBase: url base del backend
    func configure(_ URLBase: String)
    
    /// Añade un nuevo header
    /// - Parameters:
    ///   - key: string
    ///   - value: string
    func setHeader(key: String, value: String)
    
    /// Elimina un header por la Key
    /// - Parameter key: string
    func removeHeader(key: String)
    
    /// GET
    /// - Parameters:
    ///   - uri: endpoint
    ///   - completion:  payload o error del servicio
    func get<T:Codable>(uri:String, completion: @escaping (Result<T,APIManagerError>) -> ())
    
    /// DELETE
    /// - Parameters:
    ///   - uri: endpoint
    ///   - completion: payload o error del servicio
    func delete<T:Codable>(uri:String, completion: @escaping (Result<T,APIManagerError>) -> ())
    
    /// POST
    /// - Parameters:
    ///   - uri: endpoint
    ///   - params: parametros del body
    ///   - completion: payload o error del servicio
    func post<T:Codable>(uri:String, params: [String: Any], completion: @escaping (Result<T,APIManagerError>) -> ())
    
    /// PUT
    /// - Parameters:
    ///   - uri: endpoint
    ///   - params: parametros del body
    ///   - completion: ayload o error de servicio
    func put<T:Codable>(uri:String, params: [String: Any], completion: @escaping (Result<T,APIManagerError>) -> ())
}

public class APIManager: APIMannagerProtocol {
    public static let shared: APIMannagerProtocol = APIManager()
    static var headers: [String: String] = [:]
    var BASE = ""
    var SUCCESSRESULTCODE = ""
    var ionixServer = false
    let defaultSession = URLSession(configuration: .default)
   
    public func configure(_ URLBase: String, resultCode: String) {
        self.BASE = URLBase
        self.SUCCESSRESULTCODE = resultCode
        self.ionixServer = true
    }
    public func configure(_ URLBase: String) {
        self.BASE = URLBase
        self.ionixServer = false
    }
    public func setHeader(key: String, value: String) {
        APIManager.headers[key] = value
    }
    
    func getHeaders() -> [String: String] {
        return APIManager.headers
    }
    
    public func removeHeader(key: String) {
        APIManager.headers.removeValue(forKey: key)
    }
}
