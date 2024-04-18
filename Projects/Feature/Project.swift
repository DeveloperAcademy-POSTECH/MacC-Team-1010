// swift-tools-version: 5.9

import ProjectDescription

let project = Project(
		name: "Feature",
		targets: [
				.target(
						name: "Feature",
						destinations: [.iPhone],
						product: .staticFramework,
						bundleId: "com.teamten.julookfeature",
						deploymentTargets: .iOS("16.0"),
						infoPlist: .default,
						sources: ["Scene/**"],
						dependencies: [
							.project(target: "FeatureHome", path: "../FeatureHome"),
							.project(target: "FeatureSearch", path: "../FeatureSearch"),
							.project(target: "FeatureEncyclopedia", path: "../FeatureEncyclopedia"),
							.project(target: "FeatureProfile", path: "../FeatureProfile"),
							.project(target: "FeatureOnboarding", path: "../FeatureOnboarding"),
							.project(target: "FeatureCamera", path: "../FeatureCamera")
						]
				),
				.target(
						name: "FeatureTests",
						destinations: [.iPhone],
						product: .unitTests,
						bundleId: "com.teamten.FeatureTests",
						infoPlist: .default,
						dependencies: [.target(name: "Feature")]
				),
		]
)
