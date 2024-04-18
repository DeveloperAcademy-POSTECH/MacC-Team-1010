// swift-tools-version: 5.9

import ProjectDescription

let project = Project(
	name: "App",
	targets: [
		.target(
			name: "App",
			destinations: [.iPhone],
			product: .app,
			bundleId: "com.teamten.julookapp",
			deploymentTargets: .iOS("16.0"),
			infoPlist: .file(path: "Support/Info.plist"),
			sources: ["Sources/**"],
			resources: ["Resources/**"],
			scripts: [
				.FirebaseCrashlyticsString
			],
			dependencies: [
				.external(name: "FirebaseCrashlytics"),
				.external(name: "FirebaseAnalytics"),
				.project(target: "Feature", path: "../Feature"),
				.project(target: "DesignSystem", path: "../DesignSystem"),
				.project(target: "Core", path: "../Core")
			],
			settings: .settings(
				base: ["OTHER_LDFLAGS":["-all_load -Objc"]],
				configurations: [
					.debug(name: .debug, xcconfig: "./Resources/Secrets.xcconfig"),
					.release(name: .release, xcconfig: "./Resources/Secrets.xcconfig")
				], defaultSettings: .recommended)
		),
		.target(
			name: "AppTests",
			destinations: [.iPhone],
			product: .unitTests,
			bundleId: "com.teamten.AppTests",
			infoPlist: .default,
			dependencies: [.target(name: "App")]
		),
	]
)

public extension TargetScript {
	static let FirebaseCrashlyticsString = TargetScript.post(
		script: """
	"/Users/kimsunghun/Desktop/ungchun/아카데미/매크로/MACC/Tuist/.build/checkouts/firebase-ios-sdk/Crashlytics/run"
	""",
		name: "Firebase Crashlytics",
		inputPaths: [
			"${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${TARGET_NAME}",
			"$(SRCROOT)/$(BUILT_PRODUCTS_DIR)/$(INFOPLIST_PATH)"
		],
		basedOnDependencyAnalysis: true
	)
}
