// swift-tools-version: 5.9

import ProjectDescription

let project = Project(
		name: "FeatureCamera",
		targets: [
				.target(
						name: "FeatureCamera",
						destinations: [.iPhone],
						product: .staticFramework,
						bundleId: "com.teamten.julookfeaturecamera",
						deploymentTargets: .iOS("16.0"),
						infoPlist: .default,
						sources: ["Scene/**"],
						dependencies: [
							.project(target: "Core", path: "../Core"),
							.project(target: "DesignSystem", path: "../DesignSystem")
						]
				),
				.target(
						name: "FeatureCameraTests",
						destinations: [.iPhone],
						product: .unitTests,
						bundleId: "com.teamten.FeatureCameraTests",
						infoPlist: .default,
						dependencies: [.target(name: "FeatureCamera")]
				),
		]
)
