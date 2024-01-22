//
//  API.swift
//  Targets
//
//  Created by Sferea-Lider on 05/10/23.
//

import Foundation
import UIKit
import Alamofire

class API {
    
    static let boundary = UUID().uuidString
    static let timeout: TimeInterval = 60
    
    static func makeURLRequest(end: Endpoints, method: Method = .GET, authorization: Bool = false, parameters: [String:Any]? = nil, contentType: ContentType = .json) -> URLRequest {
        
        let url = URL(string: end.endPoint)!
        
        return makeURLRequest(url: url, method: method, authorization: authorization, parameters: parameters, contentType: contentType)
    }
    
    static func makeURLRequest(url: URL, method: Method = .GET, authorization: Bool = false, parameters: [String:Any]? = nil, contentType: ContentType = .json) -> URLRequest {
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        var content = contentType.rawValue
        if contentType == .multipart {
            content = "\(content); boundary=\(boundary)"
        }
        urlRequest.setValue(content, forHTTPHeaderField: "Content-Type")
        
//        if authorization, let token = token {
//            urlRequest.setValue("Bearer \(token)",forHTTPHeaderField: "Authorization")
//        }
        
        urlRequest.timeoutInterval = timeout
        
        if let params = parameters {
            if method == .GET {
                //TODO: Change this implementacion to betterone
                let jsonString = params.reduce("") { "\($0)\($1.0)=\($1.1)&" }.dropLast()
                let newUrl = URL(string: "\(url.absoluteString)?\(jsonString)")
                urlRequest.url = newUrl
            } else {
                urlRequest.httpBody = parametersToData(parameters: params, contentType: contentType)
            }
        }
        
        return urlRequest
    }
    
    static func parametersToData(parameters: [String:Any], contentType: ContentType = .json) -> Data {
        switch contentType {
        case .json:
            return try! JSONSerialization.data(withJSONObject: parameters, options: [])
        case .form:
            let jsonString = parameters.reduce("") { "\($0)\($1.0)=\($1.1)&" }.dropLast()
            return jsonString.data(using: .utf8, allowLossyConversion: false)!
        case .multipart:
            var data = Data()
            for param in parameters {
                guard let url = param.value as? URL else{
                    continue
                }
                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(param.key)\"; filename=\"\(url.lastPathComponent)\"\r\n".data(using: .utf8)!)
                data.append("Content-Type: \(url.mimeType())\r\n\r\n".data(using: .utf8)!)
                let fileData = try? Data(contentsOf: url)
                if url.containsImage {
                    data.append(UIImage(data: fileData!)!.jpegData(compressionQuality: 0.5)!)
                } else {
                    data.append(fileData!)
                }
            
            }
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            
            return data
        }
    }
    
    static func request(url: URLRequest, completion: @escaping (Data?, CodeResponse) -> ()) {
        if !NetworkMonitor.isConnectedToNetwork(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                completion(nil, .not_conection)
            }
            return
        }
        
        AF.request(url).validate().response { data in
            guard let response = data.response else {
                completion(nil, .unowned)
                return
            }
            
            let code = CodeResponse(rawValue:  response.statusCode) ?? .unowned
            completion(data.data, code)
        }
    }
}

enum Method: String {
    case GET
    case POST
    case DELETE
}

enum ContentType: String {
    case json = "application/json"
    case form = "application/x-www-form-urlencoded"
    case multipart = "multipart/form-data"
}

enum Endpoints {
    case digimon
    
    var endPoint: String {
        switch self {
        case .digimon:
            return "https://www.digi-api.com/api/v1/digimon"
        }
    }
}

enum CodeResponse: Int {
    case success = 200
    case bad_request = 400
    case error_server = 500
    case not_conection = -1001
    case timeout = -1002
    case bad_url = -1003
    case bad_decodable = -1004
    case copy_file_error = -1005
    case unowned = -1006
    
    var message: String {
        switch self {
        case .success:
            return "Exitoso"
        case .bad_request, .error_server:
            return "Ha ocurrido un error"
        default:
            return "Error interno"
        }
    }
}
