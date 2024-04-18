// swift-tools-version: 5.9

import PackageDescription


#if TUIST
import ProjectDescription


let packageSettings = PackageSettings(
		productTypes: [
				"Moya": .framework,
				"Kingfisher": .framework,
				"Mixpanel": .framework,
				"Firebase": .framework
		]
)
#endif


let package = Package(
		name: "PackageName",
		dependencies: [
				.package(url: "https://github.com/Moya/Moya", from: "15.0.0"),
				.package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0"),
				.package(url: "https://github.com/mixpanel/mixpanel-swift", from: "4.0.0"),
				.package(url: "https://github.com/firebase/firebase-ios-sdk", from: "10.24.0")
		]
)
