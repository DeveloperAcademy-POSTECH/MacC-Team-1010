// swift-tools-version: 5.9

import ProjectDescription

let project = Project(
		name: "FeatureSearch",
		targets: [
				.target(
						name: "FeatureSearch",
						destinations: [.iPhone],
						product: .staticFramework,
						bundleId: "com.teamten.julookfeaturesearch",
						deploymentTargets: .iOS("16.0"),
						infoPlist: .default,
						sources: ["Scene/**"],
						dependencies: [
							.external(name: "Kingfisher", condition: .none),
							.project(target: "Core", path: "../Core"),
							.project(target: "DesignSystem", path: "../DesignSystem"),
							.project(target: "FeatureHome", path: "../FeatureHome"),
							.project(target: "FeatureInformation", path: "../FeatureInformation")
						]
				),
				.target(
						name: "FeatureSearchTests",
						destinations: [.iPhone],
						product: .unitTests,
						bundleId: "com.teamten.FeatureSearchTests",
						infoPlist: .default,
						dependencies: [.target(name: "FeatureSearch")]
				),
		]
)
