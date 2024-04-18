// swift-tools-version: 5.9

import ProjectDescription

let project = Project(
		name: "Utils",
		targets: [
				.target(
						name: "Utils",
						destinations: [.iPhone],
						product: .framework,
						bundleId: "com.teamten.julookutils",
						deploymentTargets: .iOS("16.0"),
						infoPlist: .default,
						sources: ["Sources/**"],
						dependencies: [
							
						]
				),
				.target(
						name: "UtilsTests",
						destinations: [.iPhone],
						product: .unitTests,
						bundleId: "com.teamten.UtilsTests",
						infoPlist: .default,
						dependencies: [.target(name: "Utils")]
				),
		]
)
