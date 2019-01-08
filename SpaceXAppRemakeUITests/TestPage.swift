//
//  TestPage.swift
//  SpaceXAppRemakeUITests
//
//  Created by Perez Willie Nwobu on 1/8/19.
//  Copyright © 2019 Perez Willie Nwobu. All rights reserved.
//

import Foundation
import XCTest

protocol TestPage {
    var testCase: XCTestCase { get }
}

extension TestPage {
    
    var app: XCUIApplication {
        return XCUIApplication()
    }
}
