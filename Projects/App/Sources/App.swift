//
//  App.swift
//  TenTen
//
//  Created by Kim SungHun on 2023/10/03.
//  Copyright © 2023 com.tenten. All rights reserved.
//

import SwiftUI
import Feature
import DesignSystem
import Core

import Firebase

@main
struct _App: App {
	@State private var isLoading: Double = 1 // 스플래시 뷰를 부르는 변수
	init() {
		FirebaseApp.configure()
		MixpanelManager.shared.initMixpanel()
	}
	var body: some Scene {
		WindowGroup {
			ZStack {
				RootView()
					.onAppear {
						UITabBar.appearance().backgroundColor = .designSystem(.darkwindow)!
						UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .designSystem(.primary)!
					}
					.accentColor(Color(uiColor: .designSystem(.primary)!))
				SplashView()
					.opacity(isLoading)
					.animation(Animation.easeInOut(duration: 0.8), value: isLoading)
					.onAppear {
						DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
							isLoading = 0
						}
					}
			}
		}
	}
}
