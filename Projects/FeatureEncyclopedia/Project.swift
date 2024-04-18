// swift-tools-version: 5.9

import ProjectDescription

let project = Project(
		name: "FeatureEncyclopedia",
		targets: [
				.target(
						name: "FeatureEncyclopedia",
						destinations: [.iPhone],
						product: .staticFramework,
						bundleId: "com.teamten.julookfeatureencyclopedia",
						deploymentTargets: .iOS("16.0"),
						infoPlist: .default,
						sources: ["Scene/**"],
						dependencies: [
							.external(name: "Kingfisher", condition: .none),
							.project(target: "Core", path: "../Core"),
							.project(target: "DesignSystem", path: "../DesignSystem"),
							.project(target: "FeatureInformation", path: "../FeatureInformation")
						]
				),
				.target(
						name: "FeatureEncyclopediaTests",
						destinations: [.iPhone],
						product: .unitTests,
						bundleId: "com.teamten.FeatureEncyclopediaTests",
						infoPlist: .default,
						dependencies: [.target(name: "FeatureEncyclopedia")]
				),
		]
)
