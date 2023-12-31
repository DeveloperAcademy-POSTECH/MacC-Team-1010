import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
	name: "Core",
	product: .staticFramework,
	dependencies: [
		.Project.Utils,
		.SPM.Moya,
		.SPM.Mixpanel
	],
	sources: ["Sources/**"]
)
