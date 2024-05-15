//
//  HomeAPI.swift
//  Core
//
//  Created by Kim SungHun on 2023/11/07.
//  Copyright © 2023 com.tenten. All rights reserved.
//

import Foundation
import Moya

public enum HomeAPI {
	case fetchRecentComments
	case fetchNewMakList
}

extension HomeAPI: TargetType {
	public var baseURL: URL {
		if let url = Bundle.main.infoDictionary?["HOME_API_URL"] as? String {
			return URL(string: url)!
		}
		return URL(string: "")!
	}
	
	public var path: String {
		switch self {
		case .fetchRecentComments:
			return "/recentComments"
		case .fetchNewMakList:
			return "/newMakList"
		}
	}
	
	public var method: Moya.Method {
		return .get
	}
	
	public var task: Moya.Task {
		return .requestPlain
	}
	
	public var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
	public var sampleData: Data {
		switch self {
		case .fetchRecentComments:
			return FetchRecentCommentsMockData
		case .fetchNewMakList:
			return FetchNewMakListMockData
		}
	}
}

extension HomeAPI {
	static public func request<T: Decodable>(target: HomeAPI, dataType: T.Type) async throws -> T {
		return try await withCheckedThrowingContinuation { continuation in
			let provider = MoyaProvider<HomeAPI>()
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
	
	static public func request(target: HomeAPI) async throws -> Response {
		return try await withCheckedThrowingContinuation { continuation in
			let provider = MoyaProvider<HomeAPI>(plugins: [MoyaCacheablePlugin()])
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
