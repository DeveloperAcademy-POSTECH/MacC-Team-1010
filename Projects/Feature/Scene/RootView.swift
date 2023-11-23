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
import FeatureCamera
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
	
	let imagePredictor = ImagePredictor()
	let predictionsToShow = 1 // 찍은 image가지고 createML 체크 후 return 값 받는 개수
	
	public init() {
		setCustomNavigationBar()
	}
	
	private let randomNickname = ["걸쭉한라쿤", "상큼한라쿤", "달달한라쿤",
								  "상큼한수달", "포근한여우", "날렵한곰"]
	
	public var body: some View {
		if KeyChainManager.shared.read(account: .userId).isEmpty {
			OnboardingView(nickname: randomNickname.randomElement()!)
		} else {
			TabView(selection: $selectedItem) {
				HomeView()
					.tabItem {
						Image(uiImage: .designSystem(.home)!)
						Text("홈")
							.font(.style(.SF10B))
					}.tag(1)
				SearchView()
					.tabItem {
						Image(uiImage: .designSystem(.search)!)
						Text("검색")
							.font(.style(.SF10B))
					}.tag(2)
				ProgressView()
					.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
					.foregroundColor(Color(uiColor: .designSystem(.white)!))
					.background(Color(uiColor: .designSystem(.darkbase)!))
					.tabItem {
						Image(systemName: "camera")
						Text("라벨 찾기")
							.font(.system(size: 10, weight: .bold))
					}.tag(3)
				EncyclopediaView()
					.tabItem {
						Image(uiImage: .designSystem(.heart)!)
						Text("내 막걸리")
							.font(.style(.SF10B))
					}.tag(4)
				ProfileView()
					.tabItem {
						Image(uiImage: .designSystem(.person)!)
						Text("내 정보")
							.font(.style(.SF10B))
					}.tag(5)
			}
			.onChange(of: selectedItem) {
				if 3 == $0 {
					self.isCameraViewPresented = true
				} else {
					self.oldSelectedItem = $0
				}
			}
			.sheet(isPresented: $isCameraViewPresented, onDismiss: {
				if image != UIImage() {
					self.selectedItem = 1
					userSelectedPhoto(image)
				} else {
					self.selectedItem = self.oldSelectedItem
				}
			}) {
				CameraView(
					viewModel: CameraViewModel(image: $image,
											   isCameraViewPresented: $isCameraViewPresented,
											   showPermissionAlert: $showPermissionAlert),
					isCameraViewPresented: $isCameraViewPresented,
					showPermissionAlert: $showPermissionAlert
				)
			}
			.fullScreenCover(item: $makId) { makHolyId in
				InformationView(makHolyId: makHolyId)
			}
			.alert(isPresented: $showEmptyImageAlert) {
				Alert(title: Text("막걸리 스캔에 실패했어요.."), message: Text("조금 더 라벨에 가깝게 찍어주시거나, 찾으시는 막걸리가 없다면 문의하기로 보내주세요."),
					  dismissButton: .default(Text("확인")))
			}
		}
	}
}

private extension RootView {
	func userSelectedPhoto(_ photo: UIImage) {
		DispatchQueue.global(qos: .userInitiated).async {
			self.classifyImage(photo)
		}
	}
	
	private func classifyImage(_ image: UIImage) {
		do {
			try self.imagePredictor.makePredictions(for: image,
													completionHandler: imagePredictionHandler)
		} catch {
			debugPrint("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
		}
	}
	
	private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
		guard let predictions = predictions else {
			return
		}
		
		let formattedPredictions = formatPredictions(predictions)
		
		let predictionString = formattedPredictions.joined(separator: "\n")
		debugPrint("predictionString \(predictionString)")
		
		let splitValue = predictionString.split(separator: " ")
		
		if Double(splitValue[1]) ?? -1.0 >= 70.0 {
			makId = Int(splitValue[0]) ?? -1
		} else {
			showEmptyImageAlert = true
		}
	}
	
	private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
		let topPredictions: [String] = predictions.prefix(predictionsToShow).map { prediction in
			var name = prediction.classification
			
			if let firstComma = name.firstIndex(of: ",") {
				name = String(name.prefix(upTo: firstComma))
			}
			return "\(name) \(prediction.confidencePercentage)"
		}
		
		return topPredictions
	}
}
