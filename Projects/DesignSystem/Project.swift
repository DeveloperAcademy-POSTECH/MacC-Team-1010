// swift-tools-version: 5.9

import ProjectDescription

let project = Project(
		name: "DesignSystem",
		targets: [
				.target(
						name: "DesignSystem",
						destinations: [.iPhone],
						product: .framework,
						bundleId: "com.teamten.julookdesignsystem",
						deploymentTargets: .iOS("16.0"),
						infoPlist: .default,
						sources: ["Sources/**"],
						resources: ["Resources/**"],
						dependencies: [

						]
				),
				.target(
						name: "DesignSystemTests",
						destinations: [.iPhone],
						product: .unitTests,
						bundleId: "com.teamten.DesignSystemTests",
						infoPlist: .default,
						dependencies: [.target(name: "DesignSystem")]
				),
		]
)
