// swift-tools-version: 5.9

import ProjectDescription

let project = Project(
		name: "FeatureOnboarding",
		targets: [
				.target(
						name: "FeatureOnboarding",
						destinations: [.iPhone],
						product: .staticFramework,
						bundleId: "com.teamten.julookfeatureonboarding",
						deploymentTargets: .iOS("16.0"),
						infoPlist: .default,
						sources: ["Scene/**"],
						dependencies: [
							.project(target: "Core", path: "../Core"),
							.project(target: "DesignSystem", path: "../DesignSystem"),
							.project(target: "FeatureHome", path: "../FeatureHome"),
							.project(target: "FeatureSearch", path: "../FeatureSearch"),
							.project(target: "FeatureEncyclopedia", path: "../FeatureEncyclopedia"),
							.project(target: "FeatureProfile", path: "../FeatureProfile")
						]
				),
				.target(
						name: "FeatureOnboardingTests",
						destinations: [.iPhone],
						product: .unitTests,
						bundleId: "com.teamten.FeatureOnboardingTests",
						infoPlist: .default,
						dependencies: [.target(name: "FeatureOnboarding")]
				),
		]
)
