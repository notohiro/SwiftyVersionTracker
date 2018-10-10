//
//  SwiftyVersionTrackerTests.swift
//  SwiftyVersionTrackerTests
//
//  Created by Hiroshi Noto on 2017/05/18.
//  Copyright © 2017 Hiroshi Noto. All rights reserved.
//

import XCTest
@testable import SwiftyVersionTracker

class SwiftyVersionTrackerTests: XCTestCase {

	override func setUp() {
		SwiftyVersionTracker<SwiftyVersionIntInt>.deleteData()
	}

	func testInit() {
		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.0.0", buildString: "1")

			XCTAssertEqual(tracker.history.count, 1)
		} catch {
			XCTFail()
		}


		do {
			_ = try SwiftyVersionTracker<SwiftyVersionError>(versionString: "1.0.0", buildString: "1")

			XCTFail()
		} catch {
			// OK
		}
	}

    func testTrack() {
		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.0.0", buildString: "1")

			XCTAssertEqual(tracker.history.count, 1)
		} catch {
			XCTFail()
		}

		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.0.0", buildString: "2")

			XCTAssertEqual(tracker.history.count, 2)
		} catch {
			XCTFail()
		}

		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.0.0", buildString: "2")

			XCTAssertEqual(tracker.history.count, 2)
		} catch {
			XCTFail()
		}

		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.0.0", buildString: "1")

			XCTAssertEqual(tracker.history.count, 3)
		} catch {
			XCTFail()
		}

		do {
			_ = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.2.a", buildString: "a")

			XCTFail()
		} catch {
			// OK
		}
    }

	func testFirstLaunch() {
		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.0.0", buildString: "1")

			XCTAssertTrue(tracker.isFirstLaunchEver)
			XCTAssertTrue(tracker.isFirstLaunchForVersion)
			XCTAssertTrue(tracker.isFirstLaunchForBuild)
		} catch {
			XCTFail()
		}

		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.0.0", buildString: "2")

			XCTAssertFalse(tracker.isFirstLaunchEver)
			XCTAssertFalse(tracker.isFirstLaunchForVersion)
			XCTAssertTrue(tracker.isFirstLaunchForBuild)
		} catch {
			XCTFail()
		}

		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.0.0", buildString: "2")

			XCTAssertFalse(tracker.isFirstLaunchEver)
			XCTAssertFalse(tracker.isFirstLaunchForVersion)
			XCTAssertFalse(tracker.isFirstLaunchForBuild)
		} catch {
			XCTFail()
		}

		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.0.0", buildString: "1")

			XCTAssertFalse(tracker.isFirstLaunchEver)
			XCTAssertFalse(tracker.isFirstLaunchForVersion)
			XCTAssertFalse(tracker.isFirstLaunchForBuild)
		} catch {
			XCTFail()
		}

		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.0.1", buildString: "1")

			XCTAssertFalse(tracker.isFirstLaunchEver)
			XCTAssertTrue(tracker.isFirstLaunchForVersion)
			XCTAssertTrue(tracker.isFirstLaunchForBuild)
		} catch {
			XCTFail()
		}
	}

	func testCurrent() {
		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.2.3", buildString: "4")

			XCTAssertEqual(tracker.current.major, 1)
			XCTAssertEqual(tracker.current.minor, 2)
			XCTAssertEqual(tracker.current.release, 3)
			XCTAssertEqual(tracker.current.build, 4)
		} catch {
			XCTFail()
		}

		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.2.3", buildString: "5")

			XCTAssertEqual(tracker.current.major, 1)
			XCTAssertEqual(tracker.current.minor, 2)
			XCTAssertEqual(tracker.current.release, 3)
			XCTAssertEqual(tracker.current.build, 5)
		} catch {
			XCTFail()
		}
	}

	func testPrevious() {
		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.2.3", buildString: "4")

			XCTAssertNil(tracker.previous)
		} catch {
			XCTFail()
		}

		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.2.3", buildString: "5")
			XCTAssertEqual(tracker.previous?.major, 1)
			XCTAssertEqual(tracker.previous?.minor, 2)
			XCTAssertEqual(tracker.previous?.release, 3)
			XCTAssertEqual(tracker.previous?.build, 4)
		} catch {
			XCTFail()
		}

		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.2.3", buildString: "5")
			XCTAssertEqual(tracker.previous?.major, 1)
			XCTAssertEqual(tracker.previous?.minor, 2)
			XCTAssertEqual(tracker.previous?.release, 3)
			XCTAssertEqual(tracker.previous?.build, 4)
		} catch {
			XCTFail()
		}
	}

	func testFirst() {
		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.2.3", buildString: "4")

			XCTAssertEqual(tracker.first.major, 1)
			XCTAssertEqual(tracker.first.minor, 2)
			XCTAssertEqual(tracker.first.release, 3)
			XCTAssertEqual(tracker.first.build, 4)
		} catch {
			XCTFail()
		}

		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.2.3", buildString: "5")

			XCTAssertEqual(tracker.first.major, 1)
			XCTAssertEqual(tracker.first.minor, 2)
			XCTAssertEqual(tracker.first.release, 3)
			XCTAssertEqual(tracker.first.build, 4)
		} catch {
			XCTFail()
		}
	}

	func testLast() {
		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.2.3", buildString: "4")

			XCTAssertNil(tracker.last)
		} catch {
			XCTFail()
		}

		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.2.3", buildString: "5")
			XCTAssertEqual(tracker.last?.major, 1)
			XCTAssertEqual(tracker.last?.minor, 2)
			XCTAssertEqual(tracker.last?.release, 3)
			XCTAssertEqual(tracker.last?.build, 4)
		} catch {
			XCTFail()
		}

		do {
			let tracker = try SwiftyVersionTracker<SwiftyVersionIntInt>(versionString: "1.2.3", buildString: "5")
			XCTAssertEqual(tracker.last?.major, 1)
			XCTAssertEqual(tracker.last?.minor, 2)
			XCTAssertEqual(tracker.last?.release, 3)
			XCTAssertEqual(tracker.last?.build, 5)
		} catch {
			XCTFail()
		}
	}
}

public struct SwiftyVersionError: SwiftyVersion {
	public typealias VersionLetters = Int
	public typealias BuildLetters = Int

	public let major: VersionLetters
	public let minor: VersionLetters
	public let release: VersionLetters
	public let build: BuildLetters

	public let versionString: String
	public let buildString: String

	public init(versionString: String?, buildString: String?) throws {
		throw SwiftyVersionIntIntError.invalidString
	}
}

extension SwiftyVersionError {
	public static func == (lhs: SwiftyVersionError, rhs: SwiftyVersionError) -> Bool {
		return lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.release == rhs.release && lhs.build == rhs.build
	}
}
