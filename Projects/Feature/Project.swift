import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
	name: "Feature",
	product: .staticFramework,
	dependencies: [
		.Project.FeatureAuth,
		.Project.FeatureHome,
		.Project.FeatureSearch,
		.Project.FeatureEncyclopedia,
		.Project.FeatureProfile,
		.Project.FeatureOnboarding
	],
	sources: ["Scene/**"]
)
