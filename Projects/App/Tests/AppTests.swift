//
//  AppTests.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim SungHun on 4/27/24.
//

import XCTest
import Moya
@testable import App
@testable import Core

/**
 - 원래는 각 모듈마다 따로 테스트를 작성해야함
 - 우선 그렇게 하려면 테스트 하려는 모듈을 .app로 바꾸고 각 모듈마다 info, secrets 등 세팅도 추가로 필요함
 - 그래서 App에 작성
 - 위에 적은 부분은 제가 생각한거라  틀릴 수도 있습니다.
 */

/**
 # Moya Test
 1. customEndpointClosure, moya에서 제공해주는 라이브러리로 실제 서버가 아닌 커스텀 엔드포인트를 만드는 과정
 2. provider를 생성 할 때, 앞에서 작성한 커스텀 엔드 포인트를 넣어줌
 3. immediatelyStub는 서버의 반응이 즉각 적인 옵션이고 0.5초나 2초도 있다.
 */

class AppTests: XCTestCase {
	
	// MARK: - FeatureHome
	
	func test_fetchNewMakList_디코딩이_성공_했을_때_막걸리_이름() throws {
		
		// given
		let expectation = XCTestExpectation()
		let customEndpointClosure = { (target: HomeAPI) -> Endpoint in
			return Endpoint(url: URL(target: target).absoluteString,
											sampleResponseClosure: { .networkResponse(200, target.sampleData) },
											method: target.method,
											task: target.task,
											httpHeaderFields: target.headers)
		}
		
		let testingProvider = MoyaProvider<HomeAPI>(endpointClosure: customEndpointClosure,
																								stubClosure: MoyaProvider.immediatelyStub)
		testingProvider.request(HomeAPI.fetchNewMakList) { result in
			switch result {
			case .success(let response):
				
				// when
				do {
					let result = try JSONDecoder().decode(NewMakListMakgeolliDetail.self,
																								from: response.data)
					// then
					XCTAssertEqual(result.makName, "아지 막걸리")
					
					/**
					 실제 제대로 된 테스트에서는
					 FeatureHome에 있는 로직에 성공, 실패한 result를 사용해서 제대로 로직이 돌아가는지 테스트 해야함
					 */
					
				} catch {
					XCTAssertNotNil(error)
				}
				
				expectation.fulfill()
			case .failure(let error):
				XCTAssertNotNil(error)
			}
		}
		
		wait(for: [expectation], timeout: 2.0)
	}
	
	// MARK: - FeatureOnboarding
	
	func test_checkNickname_닉네임_중복_아닐_때() throws {
		
		// given
		let expectation = XCTestExpectation()
		let customEndpointClosure = { (target: UserAPI) -> Endpoint in
			return Endpoint(url: URL(target: target).absoluteString,
											sampleResponseClosure: { .networkResponse(200, target.sampleData) },
											method: target.method,
											task: target.task,
											httpHeaderFields: target.headers)
		}
		
		let testingProvider = MoyaProvider<UserAPI>(endpointClosure: customEndpointClosure,
																								stubClosure: MoyaProvider.immediatelyStub)
		testingProvider.request(UserAPI.checkNickname(nickname: "아지")) { result in
			switch result {
			case .success(let response):
				
				// when
				do {
					let result = try JSONDecoder().decode(CheckNicknameResult.self,
																								from: response.data)
					
					// then
					XCTAssertEqual(result.isSuccess, true)
					
					/**
					 실제 제대로 된 테스트에서는
					 FeatureOnboarding에 있는 로직에 성공, 실패한 result를 사용해서 제대로 로직이 돌아가는지 테스트 해야함
					 */
					
				} catch {
					XCTAssertNotNil(error)
				}
				
				expectation.fulfill()
			case .failure(let error):
				XCTAssertNotNil(error)
			}
		}
		
		wait(for: [expectation], timeout: 2.0)
	}
	
	override func setUpWithError() throws {
		
	}
	
	override func tearDownWithError() throws {
		
	}
}
