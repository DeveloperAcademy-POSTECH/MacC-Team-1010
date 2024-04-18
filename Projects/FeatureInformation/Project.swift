// swift-tools-version: 5.9

import ProjectDescription

let project = Project(
		name: "FeatureInformation",
		targets: [
				.target(
						name: "FeatureInformation",
						destinations: [.iPhone],
						product: .staticFramework,
						bundleId: "com.teamten.julookfeatureinformation",
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
						name: "FeatureInformationTests",
						destinations: [.iPhone],
						product: .unitTests,
						bundleId: "com.teamten.FeatureInformationTests",
						infoPlist: .default,
						dependencies: [.target(name: "FeatureInformation")]
				),
		]
)
