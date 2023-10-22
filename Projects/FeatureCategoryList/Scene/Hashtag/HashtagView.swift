//
//  HashtagView.swift
//  FeatureCategoryList
//
//  Created by Kim SungHun on 2023/10/20.
//  Copyright © 2023 com.tenten. All rights reserved.
//

import SwiftUI
import Core

struct HashtagView: View {
	let type: CategoryType
	
	@ObservedObject var viewModel: CategoryListViewModel
	@Binding var targetTitle: String
	
	var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(spacing: 10) {
				switch type {
				case .characteristics:
					createCharacteristicsHashtag()
				case .price:
					createPriceHashtag()
				case .region:
					createRegionHashtag()
				}
			}
		}
	}
}

private extension HashtagView {
	@ViewBuilder
	func createCharacteristicsHashtag() -> some View {
		ForEach(CharacteristicsType.allCases, id: \.self) { characteristics in
			HashtagSingleView(title: characteristics.description,
							  viewModel: viewModel,
							  targetTitle: $targetTitle)
		}
	}
	
	@ViewBuilder
	func createPriceHashtag() -> some View {
		ForEach(PriceType.allCases, id: \.self) { price in
			HashtagSingleView(title: price.description,
							  viewModel: viewModel,
							  targetTitle: $targetTitle)
		}
	}
	
	@ViewBuilder
	func createRegionHashtag() -> some View {
		ForEach(RegionType.allCases, id: \.self) { region in
			HashtagSingleView(title: region.rawValue,
							  viewModel: viewModel,
							  targetTitle: $targetTitle)
		}
	}
}
