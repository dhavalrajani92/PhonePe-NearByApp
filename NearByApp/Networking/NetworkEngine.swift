//
//  NetworkEngine.swift
//  NearByApp
//
//  Created by Dhaval Rajani on 11/25/23.
//

import Foundation

struct MyCustomError: Error {
  let message: String?
}

protocol ApiProtocol {
  func request<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> ())
}

final class NetworkEngine: ApiProtocol {
  func request<T: Decodable>(endpoint endPoint: Endpoint, completion: @escaping(Result<T, Error>)->()) {
    var urlComponents = URLComponents()
    urlComponents.scheme = endPoint.scheme
    urlComponents.host = endPoint.baseUrl
    urlComponents.path = endPoint.path
    urlComponents.queryItems = endPoint.parameters
    urlComponents.queryItems?.append(URLQueryItem(name: "client_id", value: "Mzg0OTc0Njl8MTcwMDgxMTg5NC44MDk2NjY5"))

    guard let url = urlComponents.url else { return }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = endPoint.method

    let session = URLSession(configuration: .default)
    let dataTask = session.dataTask(with: urlRequest) { data, responseData, error in
      guard (error == nil) else {
        completion(.failure(MyCustomError(message: "Something went wrong!!")))
        return
      }

      guard let statusCode = (responseData as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
        completion(.failure(MyCustomError(message: error?.localizedDescription)))
        return
      }

      guard let data = data else {
        completion(.failure(MyCustomError(message: "Something went wrong!!")))
        return
      }

      do {
        let jsonData = try JSONDecoder().decode(T.self, from: data)
        completion(.success(jsonData))
      } catch let error {
        completion(.failure(MyCustomError(message: error.localizedDescription)))
      }
    }

    dataTask.resume()
  }
}

