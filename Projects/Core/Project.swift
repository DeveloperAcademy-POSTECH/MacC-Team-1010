// swift-tools-version: 5.9

import ProjectDescription

let project = Project(
		name: "Core",
		targets: [
				.target(
						name: "Core",
						destinations: [.iPhone],
						product: .staticFramework,
						bundleId: "com.teamten.julookcore",
						deploymentTargets: .iOS("16.0"),
						infoPlist: .default,
						sources: ["Sources/**"],
						dependencies: [
								.external(name: "Moya", condition: .none),
								.external(name: "Mixpanel", condition: .none),
								.project(target: "Utils", path: "../Utils")
						]
				),
				.target(
						name: "CoreTests",
						destinations: [.iPhone],
						product: .unitTests,
						bundleId: "com.teamten.CoreTests",
						infoPlist: .default,
						dependencies: [.target(name: "Core")]
				),
		]
)
