//
//  HttpService.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 27.04.2025.
//

import Alamofire

protocol HttpServiceProtocol {
  func get<T: Decodable>(url: String, parameters: [String: Any]?, completion: @escaping (Result<T, Error>) -> Void)
  func post<T: Decodable>(url: String, parameters: [String: Any], completion: @escaping (Result<T, Error>) -> Void)
}

class HttpService: HttpServiceProtocol {
  
  func get<T: Decodable>(url: String, parameters: [String: Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
    AF.request(url, parameters: parameters)
      .validate()
      .responseDecodable(of: T.self) { response in
        switch response.result {
        case .success(let decoded):
          completion(.success(decoded))
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
  
  func post<T: Decodable>(url: String, parameters: [String: Any], completion: @escaping (Result<T, Error>) -> Void) {
    AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
      .validate()
      .responseDecodable(of: T.self) { response in
        switch response.result {
        case .success(let decoded):
          completion(.success(decoded))
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
}
