//
//  WeatherAppTestTests.swift
//  WeatherAppTestTests
//
//  Created by walidS on 10/2/2022.
//

import XCTest
@testable import WeatherAppTest

class WeatherAppTestTests: XCTestCase {

    var homeViewController : HomeViewController!

    override func setUp() {
        super.setUp()
        homeViewController = HomeViewController()
    }

    override class func tearDown() {
        super.tearDown()
    }

    func TestFirstInitialisationWeatherAPI()  {
        homeViewController.InitialLoad(city: "")
        XCTAssertNotNil(homeViewController.viewModel?.currentWeather)
    }
    
    func TestDateFormat(){
        var dateTest = " 56 / 54 / "
        XCTAssertNotNil(dateTest.ToDate())
        dateTest = "  "
        XCTAssertNotNil(dateTest.ToDate())
        dateTest = "12:55 PM"
        XCTAssertEqual(dateTest.ToDate()?.getOnlyTime(), "12:55 PM")
    }

}
