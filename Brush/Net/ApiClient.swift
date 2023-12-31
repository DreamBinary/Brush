//
//  ApiClient.swift
//  Brush
//
//  Created by cxq on 2023/8/2.
//

import Foundation

struct ApiClient {
    enum Method: String {
        case GET
        case POST
    }
    
    static func request<T: Codable>(
        _ url: String,
        method: Method = .GET,
        params: [String: Any] = [:],
        headers: [String: String] = [:]
    ) async throws -> Response<T?> {
        // 1. 创建URL
        guard let url = URL(string: url) else {
            print(url)
            fatalError("URL is not correct!")
        }
        
        // 2. 创建请求
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // 3. 设置请求头
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // 4. 设置请求体
        if method == .POST {
            let data = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.httpBody = data
        }
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // convert data to string
//        let dataString = String(data: data, encoding: .utf8)
//        print(dataString)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = formatter.date(from: dateString) {
                return date
            }
            
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot decode date string \(dateString)"
            )
            
        })
        
        let response = try decoder.decode(Response<T?>.self, from: data)
        return response
        
        //        // 5. 创建任务
        //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        //            // 6. 处理结果
        //            if let error = error {
        //                completion(.failure(error))
        //                return
        //            }
        //
        //            guard let data = data else {
        //                fatalError("Data is nil!")
        //            }
        //
        //            let decoder = JSONDecoder()
        //
        //            do {
        //                let result = try decoder.decode(T.self, from: data)
        //                completion(.success(result))
        //            } catch {
        //                completion(.failure(error))
        //            }
        //        }
        
        // 7. 开始任务
        //        task.resume()
    }
    
    
    static func logout<T: Codable>(
        _ url: String,
        param: Int = 0
    ) async throws -> Response<T?> {
        guard let url = URL(string: url) else {
            print(url)
            fatalError("URL is not correct!")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        let json = try? JSONSerialization.data(withJSONObject: [param], options: [])
//        request.httpBody = json
        
        let parameters = "\(param)"
        let postData: Data? = parameters.data(using: .utf8)
        request.httpBody = postData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let response = try decoder.decode(Response<T?>.self, from: data)
        return response
    }
}
