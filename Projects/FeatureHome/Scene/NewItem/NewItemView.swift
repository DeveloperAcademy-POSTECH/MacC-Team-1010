//
//  NewItemView.swift
//  FeatureHome
//
//  Created by Kim SungHun on 2023/10/30.
//  Copyright © 2023 com.tenten. All rights reserved.
//

import SwiftUI
import Core
import FeatureCategory

struct NewItemView: View {
	@ObservedObject var viewModel: HomeViewModel
	
	var body: some View {
		VStack(spacing: 0) {
			NavigationLink {
				CategoryView(type: .new, targetTitle: [])
			} label: {
				HStack(spacing: 4) {
					Text("새로 나왔어요")
						.font(.style(.SF20B))
						.foregroundColor(Color(uiColor: .designSystem(.white)!))
					Image(systemName: "chevron.right")
						.font(.system(size: 20, weight: .bold))
						.foregroundColor(Color(uiColor: .designSystem(.white)!))
					Spacer()
				}
				.padding(.leading, 16)
			}
			Spacer()
				.frame(height: 20)
			ScrollView(.horizontal, showsIndicators: false) {
				HStack(spacing: 16) {
					Spacer()
						.frame(width: 16, height: 1)
						.padding(.trailing, -16)
					ForEach(viewModel.newItems.prefix(10), id: \.self) { item in
						NewItemSingleView(viewModel: viewModel, item: item)
					}
					Spacer()
						.frame(width: 16, height: 1)
						.padding(.leading, -16)
				}
			}
		}
	}
}
