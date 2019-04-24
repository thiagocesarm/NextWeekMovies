//
//  API.swift
//  NextWeekMovies
//
//  Created by Thiago Lucena on 24/04/19.
//  Copyright © 2019 Thiago Lucena. All rights reserved.
//

import Foundation

enum APIResult<T, U> where U: Error {
    case success(T)
    case failure(U)
}

enum APIError: Error {
    case jsonDecodingError
    case apiRequestFailure
    
    var localizedDescription: String {
        switch self {
        case .jsonDecodingError:
            return "Error parsing JSON response to desired object"
        case .apiRequestFailure:
            return "API request failed"
        }
    }
}
