//
//  MainView.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim SungHun on 2023/10/03.
//

import SwiftUI
import Core
import DesignSystem
import Utils
import FeatureEncyclopedia
import FeatureHome
import FeatureProfile
import FeatureSearch
import FeatureOnboarding
import FeatureInformation

public struct RootView: View {
	@State var showPermissionAlert = false
	@State var showEmptyImageAlert = false
	@State var isCameraViewPresented = false
	@State var selectedItem: Int = 1
	@State var oldSelectedItem = 1
	@State var makId: Int?
	@State var image: UIImage = UIImage()
	
	let predictionsToShow = 1 // 찍은 image가지고 createML 체크 후 return 값 받는 개수
	
	public init() {
		setCustomNavigationBar()
	}
	
	public var body: some View {
		if KeyChainManager.shared.read(account: .userId).isEmpty {
			PhoneNumberAuthView()
		} else {
			TabView(selection: $selectedItem) {
				HomeView()
					.tabItem {
						Image(uiImage: .designSystem(.home)!)
						Text("모아보기")
							.font(.style(.SF10B))
					}.tag(1)
				SearchView()
					.tabItem {
						Image(uiImage: .designSystem(.search)!)
						Text("검색")
							.font(.style(.SF10B))
					}.tag(2)
				EncyclopediaView()
					.tabItem {
						Image(uiImage: .designSystem(.heart)!)
						Text("내 막걸리")
							.font(.style(.SF10B))
					}.tag(3)
				ProfileView()
					.tabItem {
						Image(uiImage: .designSystem(.person)!)
						Text("내 정보")
							.font(.style(.SF10B))
					}.tag(4)
			}
			.onChange(of: selectedItem) {
				self.oldSelectedItem = $0
			}
		}
	}
}
