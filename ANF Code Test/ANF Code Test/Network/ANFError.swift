//
//  CardDetailsViewModel.swift
//  ANF Code Test
//
//  Created by Kaushik Palle Venkata on 8/27/21.
//

import Foundation

public enum ANFError: Error {
    public enum ParseFailureReason {
        case formInvalid
        case codeCanNotFound
        case messageCanNotFound
        case dataNotFound
    }
    
    public struct BusinessFailedReason {
        public let code: Int
        public let message: String
        public init(code: Int, message: String) {
            self.code = code
            self.message = message
        }
    }
    
    case internalFailed(reason: String)
    case networkError(reason: Error)
    case parseFailed(reason: ParseFailureReason)
    case businessFailed(reason: BusinessFailedReason)
}

extension ANFError.BusinessFailedReason: CustomStringConvertible {
    public var description: String {
        return "code: \(code), message: \(message)"
    }
}

extension ANFError.BusinessFailedReason: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "code: \(code), message: \(message)"
    }
}

extension ANFError: LocalizedError {
    /// A localized message describing what error occurred.
    public var errorDescription: String? {
        switch self {
        case .networkError(reason: let reason):
            return reason.localizedDescription
        case .parseFailed(reason: let reason):
            return "Parse Failed: \(reason)"
        case .businessFailed(reason: let reason):
            return "Business Failed: \(reason)"
        case .internalFailed(reason: let reason):
          return "Failed: \(reason)"
      }
    }
}

extension ANFError: CustomStringConvertible {
    public var description: String {
        return localizedDescription
    }
}

extension ANFError: CustomDebugStringConvertible {
    public var debugDescription: String {
        return localizedDescription
    }
}
