//
//  LaunchTableVCPage.swift
//  SpaceXAppRemakeUITests
//
//  Created by Perez Willie Nwobu on 1/8/19.
//  Copyright © 2019 Perez Willie Nwobu. All rights reserved.
//

import Foundation
import XCTest

struct LaunchDetailVCCollectionViewTestPage : TestPage {
    
    var testCase: XCTestCase
    
    var collectionView : XCUIElement {
        return app.collectionViews.element(boundBy: 0)
    }
    
    func collectionViewCell(at index : Int) -> XCUIElement {
        return collectionView.cells.element(boundBy: index)
    }
    
    @discardableResult func verifyCollectionViewPageIsShowing(file: String = #file, line: UInt = #line) -> LaunchDetailVCCollectionViewTestPage{
        testCase.expect(exists: collectionView, file: file, line: line)
        return self
}

@discardableResult func verifyPhotoCollectionViewCellIsShowing(file: String = #file, line: UInt = #line) -> LaunchDetailVCCollectionViewTestPage {
    testCase.expect(exists: collectionViewCell(at: 0), file: file, line: line)
    collectionViewCell(at: 0).tap()
    return self
}
}
