//
//  SpaceXAppRemakeUITests.swift
//  SpaceXAppRemakeUITests
//
//  Created by Perez Willie Nwobu on 1/8/19.
//  Copyright © 2019 Perez Willie Nwobu. All rights reserved.
//

import XCTest

class SpaceXAppRemakeUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["UITesting"]
        app.launch()
    }
    
    func testTableViewElementsArePresentAtLaunch() {
        LaunchTableViewControllerPage(testCase: self)
           .verifyTableViewPageIsShowing()
        .verifyLaunchTableViewCellIsShowing()
    }
    
    
    //if this fails, this is probably because some flickR images are not present so the collectionView is empty, I should definitely fill the collectionView cell with default data for better UX.
    func testCollectionViewElementsAreShowing(){
        LaunchDetailVCCollectionViewTestPage(testCase: self)
        .verifyCollectionViewPageIsShowing()
        .verifyPhotoCollectionViewCellIsShowing()
    }

}
