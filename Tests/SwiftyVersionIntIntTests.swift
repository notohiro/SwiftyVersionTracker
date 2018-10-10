//
//  SwiftyVersionIntIntTests.swift
//  SwiftyVersionTracker
//
//  Created by Hiroshi Noto on 2017/05/19.
//  Copyright © 2017 Hiroshi Noto. All rights reserved.
//

import XCTest
@testable import SwiftyVersionTracker

class SwiftyVersionIntIntTests: XCTestCase {
	func testNumbers() {
		let versionString: String? = "1.2.3"
		let buildString: String? = "4"

		do {
			let version1 = try SwiftyVersionIntInt(versionString: versionString, buildString: buildString)

			XCTAssertEqual(version1.major, 1)
			XCTAssertEqual(version1.minor, 2)
			XCTAssertEqual(version1.release, 3)
			XCTAssertEqual(version1.build, 4)

		} catch {
			XCTFail()
		}

		do {
			_ = try SwiftyVersionIntInt(versionString: "1.2", buildString: "4")
			XCTFail()
		} catch {
			// OK
		}
	}

	func testBlank() {
		do {
			_ = try SwiftyVersionIntInt(versionString: "", buildString: "")
		} catch {
			// OK
		}

		do {
			_ = try SwiftyVersionIntInt(versionString: "", buildString: "4")
		} catch {
			// OK
		}

		do {
			_ = try SwiftyVersionIntInt(versionString: "1.2.3", buildString: "")
		} catch {
			// OK
		}
	}

	func testSpace() {
		do {
			_ = try SwiftyVersionIntInt(versionString: " ", buildString: " ")
		} catch {
			// OK
		}

		do {
			_  = try SwiftyVersionIntInt(versionString: " ", buildString: "4")
		} catch {
			// OK
		}

		do {
			_ = try SwiftyVersionIntInt(versionString: "1.2.3", buildString: " ")
		} catch {
			// OK
		}
	}

	func testStrings() {
		do {
			_ = try SwiftyVersionIntInt(versionString: "abc", buildString: "d")
		} catch {
			// OK
		}

		do {
			_ = try SwiftyVersionIntInt(versionString: "abc", buildString: "4")
		} catch {
			// OK
		}

		do {
			_ = try SwiftyVersionIntInt(versionString: "1.2.3", buildString: "d")
		} catch {
			// OK
		}
	}
}
