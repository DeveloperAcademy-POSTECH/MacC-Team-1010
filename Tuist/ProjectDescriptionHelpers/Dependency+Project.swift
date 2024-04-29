//
//  Dependency+Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim SungHun on 2023/09/24.
//

import ProjectDescription

public extension TargetDependency {
	enum Project {}
}

public extension TargetDependency.Project {
	static let Core = TargetDependency.project(target: "Core", path: .relativeToRoot("Projects/Core"))
	static let Utils = TargetDependency.project(target: "Utils", path: .relativeToRoot("Projects/Utils"))
	static let DesignSystem = TargetDependency.project(target: "DesignSystem", path: .relativeToRoot("Projects/DesignSystem"))
	static let Feature = TargetDependency.project(target: "Feature", path: .relativeToRoot("Projects/Feature"))
	static let FeatureHome = TargetDependency.project(target: "FeatureHome", path: .relativeToRoot("Projects/FeatureHome"))
	static let FeatureInformation = TargetDependency.project(target: "FeatureInformation", path: .relativeToRoot("Projects/FeatureInformation"))
	static let FeatureCategory = TargetDependency.project(target: "FeatureCategory", path: .relativeToRoot("Projects/FeatureCategory"))
	static let FeatureSearch = TargetDependency.project(target: "FeatureSearch", path: .relativeToRoot("Projects/FeatureSearch"))
	static let FeatureEncyclopedia = TargetDependency.project(target: "FeatureEncyclopedia", path: .relativeToRoot("Projects/FeatureEncyclopedia"))
	static let FeatureProfile = TargetDependency.project(target: "FeatureProfile", path: .relativeToRoot("Projects/FeatureProfile"))
	static let FeatureOnboarding = TargetDependency.project(target: "FeatureOnboarding", path: .relativeToRoot("Projects/FeatureOnboarding"))
}
