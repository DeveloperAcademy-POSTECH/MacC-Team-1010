//
//  HomeViewModel.swift
//  FeatureHome
//
//  Created by Kim SungHun on 2023/11/02.
//  Copyright © 2023 com.tenten. All rights reserved.
//

import Foundation
import Core

final class HomeViewModel: ObservableObject {
	@Published var fetchLoading = true
	@Published var newItems: [MakHolyMini] = MakHolyMini.mokDatas
	@Published var comments: [Comment] = Comment.mockDatas
	
	let makgeolliRepository: DefaultMakgeolliRepository
	
	init(
		makgeolliRepository: DefaultMakgeolliRepository
	) {
		self.makgeolliRepository = makgeolliRepository
	}
	
	@MainActor
	func fetchNewMakgeolli() {
		Task {
			do {
				//				let response = try await makgeolliRepository.fetchMakgeolliList()
				//				newItems = (response.result?.contents)!
				
//				let response = try await makgeolliRepository.findByFeatures(
//					FindByFeaturesRequest(sort: 5,
//												   category: nil,
//												   pageable: FindByFeaturesPageable(page: 0, size: 0, sort: []))
//				)
//				print("response \(response)")
				
				fetchLoading = false
			} catch {
				// error
				
				Logger.debug(error: error, message: "")
			}
		}
	}
}
