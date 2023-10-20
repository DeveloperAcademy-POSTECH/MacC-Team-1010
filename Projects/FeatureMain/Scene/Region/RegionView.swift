//
//  RegionView.swift
//  FeatureMain
//
//  Created by Kim SungHun on 2023/10/18.
//  Copyright © 2023 com.tenten. All rights reserved.
//

import SwiftUI
import Core

struct RegionView: View {
	
	var body: some View {
		VStack(spacing: 0) {
			HStack(spacing: 0) {
				Text("지역별")
					.font(.system(size: 18, weight: .bold))
					.foregroundColor(.white)
				Text("로 찾기")
					.font(.system(size: 18, weight: .regular))
					.foregroundColor(.white)
				Spacer()
				Image(systemName: "chevron.right")
					.foregroundColor(.white)
					.padding(.trailing, 16)
			}
			Spacer()
				.frame(height: 16)
			ScrollView(.horizontal, showsIndicators: false) {
				HStack {
					ForEach(RegionType.allCases, id: \.self) { region in
						RegionSingleView(title: region.rawValue)
					}
				}
			}
		}
		.padding(.leading, 16)
	}
}

struct RegionView_Previews: PreviewProvider {
	static var previews: some View {
		RegionView()
	}
}