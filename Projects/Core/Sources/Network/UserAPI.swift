//
//  AuthAPI.swift
//  Core
//
//  Created by Kim SungHun on 2023/11/06.
//  Copyright © 2023 com.tenten. All rights reserved.
//

import Foundation
import Moya

public enum UserAPI {
	case getUserMakFolder(parameter: [String: Any])
	case checkNickname(nickname: String)
	
	case phoneSignin(parameter: AuthUserRequest)
	case skipSignin(parameter: UserRequest)
	case updateComment(parameter: UpdateCommentRequest)
	case insertComment(parameter: InsertCommentRequest)
	case deleteComment(parameter: DeleteCommentRequest)
	case evaluateMak(parameter: EvaluateMakRequest)
	case addWishList(parameter: WishListRequest)
	case deleteWishList(parameter: WishListRequest)
}

extension UserAPI: TargetType {
	public var baseURL: URL {
		if let url = Bundle.main.infoDictionary?["USER_API_URL"] as? String {
			return URL(string: url)!
		}
		return URL(string: "")!
	}
	
	public var path: String {
		switch self {
		case .getUserMakFolder:
			return "/getUserMakFolder"
		case .checkNickname(let nickname):
			return "/checkNickname/\(nickname)"
			
		case .phoneSignin:
			return "/phoneSignIn"
		case .skipSignin:
			return "/SkipSignIn"
		case .updateComment:
			return "/updateComment"
		case .insertComment:
			return "/insertComment"
		case .deleteComment:
			return "/deleteComment"
		case .evaluateMak:
			return "/evaluateMak"
		case .addWishList:
			return "/addWishList"
		case .deleteWishList:
			return "/deleteWishList"
		}
	}
	
	public var method: Moya.Method {
		switch self {
		case .getUserMakFolder:
			return .get
		case .checkNickname:
			return .get
		default:
			return .post
		}
	}
	
	public var task: Moya.Task {
		switch self {
		case .getUserMakFolder(let parameter):
			return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
		case .checkNickname:
			return .requestPlain
			
		case .phoneSignin(let parameter):
			return .requestJSONEncodable(parameter)
		case .skipSignin(let parameter):
			return .requestJSONEncodable(parameter)
		case .updateComment(let parameter):
			return .requestJSONEncodable(parameter)
		case .insertComment(let parameter):
			return .requestJSONEncodable(parameter)
		case .deleteComment(let parameter):
			return .requestJSONEncodable(parameter)
		case .evaluateMak(let parameter):
			return .requestJSONEncodable(parameter)
		case .addWishList(let parameter):
			return .requestJSONEncodable(parameter)
		case .deleteWishList(let parameter):
			return .requestJSONEncodable(parameter)
		}
	}
	
	public var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
	public var sampleData: Data {
		switch self {
		case .checkNickname:
			return CheckNicknameMockData
		default:
			return Data()
		}
	}
}

extension UserAPI {
	static public func request<T: Decodable>(target: UserAPI, dataType: T.Type) async throws -> T {
		return try await withCheckedThrowingContinuation { continuation in
			let provider = MoyaProvider<UserAPI>()
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
	
	static public func request(target: UserAPI) async throws -> Response {
		return try await withCheckedThrowingContinuation { continuation in
			let provider = MoyaProvider<UserAPI>(plugins: [MoyaCacheablePlugin()])
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
