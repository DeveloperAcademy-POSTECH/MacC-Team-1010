// swift-tools-version: 5.9

import ProjectDescription

let project = Project(
		name: "FeatureProfile",
		targets: [
				.target(
						name: "FeatureProfile",
						destinations: [.iPhone],
						product: .staticFramework,
						bundleId: "com.teamten.julookfeatureprofile",
						deploymentTargets: .iOS("16.0"),
						infoPlist: .default,
						sources: ["Scene/**"],
						dependencies: [
							.external(name: "Kingfisher", condition: .none),
							.project(target: "Core", path: "../Core"),
							.project(target: "DesignSystem", path: "../DesignSystem")
						]
				),
				.target(
						name: "FeatureProfileTests",
						destinations: [.iPhone],
						product: .unitTests,
						bundleId: "com.teamten.FeatureProfileTests",
						infoPlist: .default,
						dependencies: [.target(name: "FeatureProfile")]
				),
		]
)
