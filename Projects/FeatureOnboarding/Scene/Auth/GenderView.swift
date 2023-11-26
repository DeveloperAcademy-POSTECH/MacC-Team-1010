//
//  GenderView.swift
//  FeatureOnboarding
//
//  Created by 박지은 on 11/25/23.
//  Copyright © 2023 com.teamten. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct GenderView: View {
	@State var genderSelected: Int?
	@State private var selected = [false, false, false]
	@State private var showAlert = false
	@State private var isSkip = false
	
	let genders = ["남성", "여성", "기타"]
	
	public init() { }
	
	public var body: some View {
		VStack(alignment: .center, spacing: 0) {
			Spacer()
			
			HStack(spacing: 0) {
				Text("성별")
					.foregroundColor(.Primary)
					.SF24B()
				Text("을 알려주세요")
					.SF24B()
			}
			.padding(.bottom, 8)
			
			Text("막걸리 추천이 더 정확해져요!")
				.SF14R()
				.foregroundColor(.W50)
				.padding(.bottom, 24)
			
			HStack(spacing: 8) {
				ForEach(0..<3) { button in
					Button(action: {
						self.selected = self.selected.enumerated().map { $0.offset == button }
					}, label: {
						ZStack {
							Rectangle()
								.cornerRadius(12)
								.frame(width: 94, height: 58)
								.foregroundColor(self.selected[button] ? Color.Lilac : Color.DarkBase)
								.overlay(
									RoundedRectangle(cornerRadius: 12)
										.stroke(Color.Lilac, lineWidth: 3)
								)
							Text(self.genders[button])
								.SF20B()
								.foregroundColor(Color.White)
						}
					})
				}
			}
			
			Spacer()
			
			nextButton()
		}
		.navigationBarItems(trailing: Button(action: {
			showAlert = true
		}, label: {
			Text("건너뛰기").SF14R().foregroundColor(.W25)
		}))
		.alert(isPresented: $showAlert) {
			Alert(title: Text("막걸리 정보를 보관할 수 없어요"),
				  message: Text("번호를 입력하지 않으면 기기 변동 시 내 막걸리 정보를 불러올 수 없어요"),
				  primaryButton: .cancel(Text("안하기")) {
				isSkip = true
			},
				  secondaryButton: .default(Text("보관하기")))
		}
		.font(.style(.SF12R))
		.padding(.horizontal, 8)
		.padding(.vertical, 16)
		.background(Color(uiColor: .designSystem(.darkbase)!))
		.toolbarBackground(Color(uiColor: .designSystem(.darkbase)!), for: .navigationBar)
		.navigationBarBackButtonHidden()
		.background(Color(uiColor: .designSystem(.darkbase)!))
		.fullScreenCover(isPresented: $isSkip, content: {
			SkipNicknameView()
		})
	}
}

private extension GenderView {
	@ViewBuilder
	func nextButton() -> some View {
		NavigationLink {
			NicknameView()
		} label: {
			RoundedRectangle(cornerRadius: 12)
				.fill(
					Color(uiColor: .designSystem(selected.contains(true) ? .goldenyellow : .w10)!)
				)
				.frame(height: 50)
				.overlay {
					Text("다음")
						.foregroundColor(selected.contains(true) ? .White : .W25)
						.SF17R()
				}
				.padding(.bottom, 16)
		}
		.disabled(!selected.contains(true))
	}
}