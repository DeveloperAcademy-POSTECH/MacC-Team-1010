// swift-tools-version: 5.9

import ProjectDescription

let project = Project(
		name: "FeatureHome",
		targets: [
				.target(
						name: "FeatureHome",
						destinations: [.iPhone],
						product: .staticFramework,
						bundleId: "com.teamten.julookfeaturehome",
						deploymentTargets: .iOS("16.0"),
						infoPlist: .default,
						sources: ["Scene/**"],
						dependencies: [
							.external(name: "Kingfisher", condition: .none),
							.project(target: "Core", path: "../Core"),
							.project(target: "DesignSystem", path: "../DesignSystem"),
							.project(target: "FeatureCategory", path: "../FeatureCategory")
						]
				),
				.target(
						name: "FeatureHomeTests",
						destinations: [.iPhone],
						product: .unitTests,
						bundleId: "com.teamten.FeatureHomeTests",
						infoPlist: .default,
						dependencies: [.target(name: "FeatureHome")]
				),
		]
)
