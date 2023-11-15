//
//  MakgeolliInformationView.swift
//  FeatureCategoryList
//
//  Created by Kim SungHun on 2023/10/20.
//  Copyright © 2023 com.tenten. All rights reserved.
//

import SwiftUI
import Core
import DesignSystem
import FeatureInformation

struct MakgeolliInfoView: View {
	@ObservedObject var viewModel: CategoryViewModel
	
	@State var showAlert = false
	
	let type: CategoryType
	let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 2)
	let targetTitle: [CharacteristicsType]
	
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			ScrollViewReader { reader in
				HStack(spacing: 4) {
					Image(systemName: "questionmark.circle.fill")
						.foregroundColor(Color(uiColor: .designSystem(.w50)!))
					Button {
						showAlert = true
					} label: {
						Text("리스트 순서가 궁금해요")
							.foregroundColor(Color(uiColor: .designSystem(.w50)!))
					}
					Spacer()
					Button {
						showAlert = true
					} label: {
						Text("추천순")
							.foregroundColor(Color(uiColor: .designSystem(.primary)!))
					}
				}
				.alert(isPresented: $showAlert) {
					Alert(title: Text("추천순으로 정렬"), message: Text("추천순으로 보여드릴 수 있도록 준비중이니 업데이트 될 때까지 조금만 기다려주세요!"),
						  dismissButton: .default(Text("확인")))
				}
				.font(.style(.SF12R))
				.padding(.horizontal, 8)
				.padding(.vertical, 16)
				
				if type != .event && viewModel.makHolys.isEmpty {
					VStack(spacing: 20) {
						Text("검색 결과가 없어요..")
							.SF17R()
							.foregroundColor(.W50)
						Image(uiImage: .designSystem(.character)!)
					}
				} else {
					LazyVGrid(columns: columns, spacing: 0) {
						ForEach(type == .event ? MakContent.mockDatas : viewModel.makHolys, id: \.self) { data in
							MakgeolliInfoSingleView(viewModel: viewModel, makHoly: data)
								.padding(.horizontal, 8)
								.padding(.bottom, 16)
								.onAppear {
									if type != .event {
										if data == viewModel.makHolys.last {
											if !viewModel.isLastPage {
												var offset = viewModel.currentOffset
												offset += 1
												withAnimation {
													viewModel.nextFetchCategoryMakgeolli(sort: nil,
																						 offset: offset,
																						 categories: targetTitle)
												}
											}
										}
									}
								}
						}
					}
				}
			}
		}
		.fullScreenCover(item: $viewModel.resultMakHolyId) { makHolyId in
			InformationView(makHolyId: makHolyId)
		}
	}
}
