import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
	name: "App",
	platform: .iOS,
	product: .app,
	dependencies: [
		.Project.Feature,
		.SPM.FirebaseCrashlytics
	],
	sources: ["Sources/**"],
	resources: ["Resources/**"],
	infoPlist: .file(path: "Support/Info.plist"),
	settings: .settings(
		base: [:],
		configurations: [
			.debug(name: .debug, xcconfig: "./Resources/Secrets.xcconfig"),
			.release(name: .release, xcconfig: "./Resources/Secrets.xcconfig")
		], defaultSettings: .recommended)
)
