// swift-tools-version: 5.9

import ProjectDescription

let project = Project(
		name: "FeatureCategory",
		targets: [
				.target(
						name: "FeatureCategory",
						destinations: [.iPhone],
						product: .staticFramework,
						bundleId: "com.teamten.julookfeaturecategory",
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
						name: "FeatureCategoryTests",
						destinations: [.iPhone],
						product: .unitTests,
						bundleId: "com.teamten.FeatureCategoryTests",
						infoPlist: .default,
						dependencies: [.target(name: "FeatureCategory")]
				),
		]
)
