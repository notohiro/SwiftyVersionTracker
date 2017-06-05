//
//  SwiftyVersion+IntInt.swift
//  SwiftyVersionTracker
//
//  Created by Hiroshi Noto on 2017/05/19.
//  Copyright © 2017 Hiroshi Noto. All rights reserved.
//

import Foundation

public enum SwiftyVersionIntIntError: Error {
	case invalidString
}

public struct SwiftyVersionIntInt: SwiftyVersion {
	public typealias VersionLetters = Int
	public typealias BuildLetters = Int

	public let major: VersionLetters
	public let minor: VersionLetters
	public let release: VersionLetters
	public let build: BuildLetters

	public let versionString: String
	public let buildString: String

	public init(versionString: String?, buildString: String?) throws {
		guard let versionString = versionString, let buildString = buildString else {
			throw SwiftyVersionIntIntError.invalidString
		}

		self.versionString = versionString
		self.buildString = buildString

		let versionStrings = versionString.components(separatedBy: ".")

		if versionStrings.count != 3 { throw SwiftyVersionIntIntError.invalidString }

		guard let major = Int(versionStrings[0]) else {
			throw SwiftyVersionIntIntError.invalidString
		}
		self.major = major

		guard let minor = Int(versionStrings[1]) else {
			throw SwiftyVersionIntIntError.invalidString
		}
		self.minor = minor

		guard let release = Int(versionStrings[2]) else {
			throw SwiftyVersionIntIntError.invalidString
		}
		self.release = release

		guard let build = Int(buildString) else {
			throw SwiftyVersionIntIntError.invalidString
		}
		self.build = build
	}
}

extension SwiftyVersionIntInt {
	public static func == (lhs: SwiftyVersionIntInt, rhs: SwiftyVersionIntInt) -> Bool {
		return lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.release == rhs.release && lhs.build == rhs.build
	}
}
