//
//  MoyaAPI.swift
//  canerDeneme3
//
//  Created by Caner Özcan on 19.09.2023.
//

import Foundation

import Moya

enum MovieService {
    case popularMovies(page:Int)
    case searchMovies(query: String)
}

extension MovieService: TargetType {
    var baseURL: URL {
        return URL(string: Constants.baseURL)!
    }

    var path: String {
        switch self {
        case .popularMovies:
            return "/movie/popular"
        case .searchMovies:
            return "/search/movie"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .popularMovies(let page):
            return .requestParameters(parameters: ["api_key": Constants.apiKey,"page":page], encoding: URLEncoding.default)
        case let .searchMovies(query):
            return .requestParameters(parameters: ["api_key": Constants.apiKey, "query": query], encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return nil
    }

    var sampleData: Data {
        return Data()
    }
}
