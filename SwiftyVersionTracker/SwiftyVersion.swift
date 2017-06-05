//
//  SwiftyVersion.swift
//  SwiftyVersionTracker
//
//  Created by Hiroshi Noto on 2017/05/18.
//  Copyright © 2017 Hiroshi Noto. All rights reserved.
//

import Foundation

public protocol SwiftyVersion: Equatable {
	associatedtype VersionLetters: Comparable
	associatedtype BuildLetters: Comparable

	var major: VersionLetters { get }
	var minor: VersionLetters { get }
	var release: VersionLetters { get }
	var build: BuildLetters { get }

	init(versionString: String?, buildString: String?) throws
}
