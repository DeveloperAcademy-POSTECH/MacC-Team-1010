//
//  Dependency+SPM.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim SungHun on 2023/09/24.
//

import ProjectDescription

public extension TargetDependency {
	enum SPM {}
}

public extension TargetDependency.SPM {
	static let Kingfisher = TargetDependency.external(name: "Kingfisher")
	static let Moya = TargetDependency.external(name: "Moya")
	static let Mixpanel = TargetDependency.external(name: "Mixpanel")
	static let FirebaseCrashlytics = TargetDependency.external(name: "FirebaseCrashlytics")
}
