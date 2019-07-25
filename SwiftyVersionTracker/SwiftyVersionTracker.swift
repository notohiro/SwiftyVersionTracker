//
//  SwiftyVersionTracker.swift
//  SwiftyVersionTracker
//
//  Created by Hiroshi Noto on 2017/05/19.
//  Copyright © 2017 Hiroshi Noto. All rights reserved.
//

import Foundation

private let kSwiftyVersionTrackerSaveKey	= "SwiftyVersionTrackerSaveKey"
private let kSwiftyVersionTrackerSaveKeyVersion = "SwiftyVersionTrackerSaveKeyVersion"
private let kSwiftyVersionTrackerSaveKeyBuild = "SwiftyVersionTrackerSaveKeyBuild"

open class SwiftyVersionTracker<T: SwiftyVersion> {
    public struct BundleVersion {
		public let version: String?
		public let build: String?
	}

	open var isFirstLaunchEver: Bool {
		return history.count <= 1
	}

	open var isFirstLaunchForVersion: Bool

	open var isFirstLaunchForBuild: Bool

	open var current: T

	open var previous: T? {
		if history.count >= 2 {
			return history[history.count - 2]
		} else {
			return nil
		}
	}

	open var first: T

	open var last: T?

	open private(set) var history = [T]()

	private var bundleVersions = [BundleVersion]()

	open private(set) var userDefaults = UserDefaults.standard

	public init(
        versionString: String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
        buildString: String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String,
        userDefaults: UserDefaults? = nil
    ) throws {
		// set UserDefaults
		if let userDefaults = userDefaults { self.userDefaults = userDefaults }

		// restore history / bundleVersion
		if let data = self.userDefaults.value(forKey: kSwiftyVersionTrackerSaveKey) as? [[String: String?]] {
			var bundleVersions = [BundleVersion]()

			data.forEach { aData in
				if let versionString = aData[kSwiftyVersionTrackerSaveKeyVersion], let buildString = aData[kSwiftyVersionTrackerSaveKeyBuild] {
					bundleVersions.append(BundleVersion(version: versionString, build: buildString))
				}
			}

			// initialize history from bundleVersions
			history = try bundleVersions.map { bundleVersion in
				try T(versionString: bundleVersion.version, buildString: bundleVersion.build)
			}

			self.bundleVersions = bundleVersions
		} else if self.userDefaults.value(forKey: kSwiftyVersionTrackerSaveKey) != nil {
			// invalid object
			SwiftyVersionTracker<T>.deleteData(userDefaults: self.userDefaults)
		}

		// set current
		let current = try T(versionString: versionString, buildString: buildString)
		self.current = current

		// set first
		if let first = history.first {
			self.first = first
		} else {
			first = current
		}

		// set isFirstLaunch
		let isFirstLaunchForVersion = history
			.filter { version in
				current.major == version.major && current.minor == version.minor && current.release == version.release
			}
			.isEmpty
		self.isFirstLaunchForVersion = isFirstLaunchForVersion

		isFirstLaunchForBuild = isFirstLaunchForVersion ? true : current.build != last?.build
		if isFirstLaunchForVersion {
			isFirstLaunchForBuild = true
		} else {
			isFirstLaunchForBuild = history
				.filter { version in
					current == version
				}
				.isEmpty
		}

		// set last
		last = history.last

		// track
		if current != last {
			let bundleVersion = BundleVersion(version: versionString, build: buildString)
			bundleVersions.append(bundleVersion)

			let version = try T(versionString: bundleVersion.version, buildString: bundleVersion.build)
			history.append(version)
		}

		save()
	}

    deinit {
        save()
    }

	private func save() {
		var bundleVersionsAsDictionary = [[String: String?]]()

		bundleVersions.forEach { bundleVersion in
			var bundleVersionAsDictionary = [String: String?]()
			bundleVersionAsDictionary[kSwiftyVersionTrackerSaveKeyVersion] = bundleVersion.version
			bundleVersionAsDictionary[kSwiftyVersionTrackerSaveKeyBuild] = bundleVersion.build

			bundleVersionsAsDictionary.append(bundleVersionAsDictionary)
		}

		userDefaults.setValue(bundleVersionsAsDictionary, forKey: kSwiftyVersionTrackerSaveKey)
		userDefaults.synchronize()
	}
}

public extension SwiftyVersionTracker {
	static func deleteData(userDefaults: UserDefaults? = nil) {
		let userDefaults = userDefaults ?? UserDefaults.standard

		userDefaults.removeObject(forKey: kSwiftyVersionTrackerSaveKey)
		userDefaults.synchronize()
	}
}
