//
//  CardDetailsViewModel.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import Alamofire

protocol Service: AnyObject {
  var configuration: ServiceConfiguration { get }
  func request(_ endpoint: EndPoint, additionalHeaders: [String: String], completion: @escaping (Result<Data?, ANFError>) -> Void)
  init(serviceConfiguration: ServiceConfiguration)
}

extension Service {
  func request(_ endpoint: EndPoint, additionalHeaders: [String: String] = [:], completion: @escaping (Result<Data?, ANFError>) -> Void) {
    if let basePath = configuration.serviceConfig.baseUrls[configuration.currentEnvi], configuration.currentEnvi != .mock {
      let completePath = basePath + endpoint.path
      let headers = additionalHeaders.map { HTTPHeader(name: $0, value: $1)}
      let request = AF.request(completePath, method: endpoint.method, parameters: endpoint.parameters, encoding: JSONEncoding.default, headers: HTTPHeaders(headers))
      request.response { result in
        guard let error = result.error else {
          return completion(.success(result.data))
        }
        completion(.failure(.networkError(reason: error)))
      }
    } else {
      guard let data = try? stubData(name: endpoint.mockPath) else {
        return completion(.failure(.businessFailed(reason: ANFError.BusinessFailedReason(code: 1, message: "Mock Issue"))))
      }
      completion(.success(data))
    }
  }
  
  func stubData(name: String) throws -> Data? {
      let bundle = Bundle(for: type(of: self))
      guard let fileUrl = bundle.url(forResource: name, withExtension: "json") else {
        return nil
      }
      let data = try? Data(contentsOf: fileUrl)
      return data
  }
}
