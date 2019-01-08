//
//  LaunchDetailVCPage.swift
//  SpaceXAppRemakeUITests
//
//  Created by Perez Willie Nwobu on 1/8/19.
//  Copyright © 2019 Perez Willie Nwobu. All rights reserved.
//

import Foundation
import XCTest

struct LaunchTableViewControllerPage : TestPage {
    
    let testCase: XCTestCase
    
    var tableView: XCUIElement {
        return app.tables.element(boundBy: 0)
    }
    
    func tableViewCell(at index : Int) -> XCUIElement {
        return tableView.cells.element(boundBy: index)
    }
    
    @discardableResult func verifyTableViewPageIsShowing(file: String = #file, line: UInt = #line) -> LaunchTableViewControllerPage {
        testCase.expect(exists: tableView, file: file, line: line)
        return self
    }
    
    //Will tap the first cell to check its presence
    @discardableResult func verifyLaunchTableViewCellIsShowing(file: String = #file, line: UInt = #line) ->LaunchTableViewControllerPage {
        testCase.expect(exists: tableViewCell(at: 0), file: file, line: line)
        tableViewCell(at: 0).tap()
        return self
    }
}
