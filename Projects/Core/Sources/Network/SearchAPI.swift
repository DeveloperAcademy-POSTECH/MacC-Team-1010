//
//  SearchAPI.swift
//  Core
//
//  Created by Kim SungHun on 2023/11/07.
//  Copyright © 2023 com.tenten. All rights reserved.
//

import Foundation
import Moya

public enum SearchAPI {
	case getSearch(parameters: [String: Any]?)
}

extension SearchAPI: TargetType {
	public var baseURL: URL {
		return URL(string: "http://43.202.219.115:8080/api/v1/search")!
	}
	
	public var path: String {
		switch self {
		case .getSearch:
			return ""
		}
	}
	
	public var method: Moya.Method {
		return .get
	}
	
	public var task: Moya.Task {
		switch self {
		case .getSearch(parameters: .none):
			return .requestPlain
		case .getSearch(let parameter):
			return .requestParameters(parameters: parameter!, encoding: URLEncoding.queryString)
		}
	}
	
	public var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
}

extension SearchAPI {
	static public func request<T: Decodable>(target: SearchAPI, dataType: T.Type) async throws -> T {
		return try await withCheckedThrowingContinuation { continuation in
			let provider = MoyaProvider<SearchAPI>()
			provider.request(target) { result in
				switch result {
				case .success(let response):
					print("request 1 didFinishRequest URL [\(response.request?.url?.absoluteString ?? "")]")
					do {
						let data = try JSONDecoder().decode(T.self, from: response.data)
						continuation.resume(returning: data)
					} catch {
						continuation.resume(throwing: error)
					}
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
	
	static public func request(target: SearchAPI) async throws -> Response {
		return try await withCheckedThrowingContinuation { continuation in
			let provider = MoyaProvider<SearchAPI>(plugins: [MoyaCacheablePlugin()])
			provider.request(target) { result in
				switch result {
				case .success(let response):
					print("request 2 didFinishRequest URL [\(response.request?.url?.absoluteString ?? "")]")
					continuation.resume(returning: response)
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
}
