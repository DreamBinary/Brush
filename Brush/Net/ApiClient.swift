//
//  ApiClient.swift
//  Brush
//
//  Created by cxq on 2023/8/2.
//

import Foundation
import Dependencies



struct ApiClient {
    
    enum Method:String {
        case GET = "GET"
        case POST = "POST"
    }
    
    static func request<T: Decodable>(
        _ url: String,
        method: Method = .GET,
        params: [String: Any] = [:],
        headers: [String: String] = [:]
    ) async throws -> T?{
        // 1. 创建URL
        guard let url = URL(string: url) else {
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
        let (data, response) =  try await URLSession.shared.data(for: request)
        let httpresponse = response as? HTTPURLResponse
        if (httpresponse?.statusCode == 200) {
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            return result
        } else {
            return .none
        } 
        
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
}


//
//}
//
//
//
//
//extension DependencyValues {
//    var apiClient: ApiClient {
//        get { self[ApiClient.self] }
//        set { self[ApiClient.self] = newValue }
//    }
//}

