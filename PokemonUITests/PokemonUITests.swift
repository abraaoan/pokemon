//
//  PokemonUITests.swift
//  PokemonUITests
//
//  Created by Abraao Nascimento on 18/10/21.
//

import XCTest

class PokemonUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func testNavigation() throws{
        
        let app = XCUIApplication()
        app.launch()
        
        let collectionView = app.collectionViews.element
        // wait elemet show up
        wait(forElement: collectionView, timeout: 5)
        
        // Test scroll and Pagination
        collectionView.swipeUp()
        sleep(1)
        collectionView.swipeUp()
        sleep(1)
        collectionView.swipeUp()
        sleep(1)
        collectionView.swipeUp()
        sleep(1)
        collectionView.swipeUp()
        collectionView.swipeUp()
        sleep(1)
        collectionView.swipeUp()
        collectionView.swipeUp()
        collectionView.swipeUp()
        
        sleep(2)
        
        // Try find a cell
        let cellIndex = getVisibleCellsQuantity() / 2
        let cell = collectionView.children(matching: .cell).element(boundBy: cellIndex)
        cell.tap()
        
        // DetailView
        let tableView = app.tables.element
        for _ in 0..<3 {
            tableView.swipeUp()
            sleep(1)
        }
        
        for _ in 0..<3 {
            tableView.swipeDown()
            sleep(1)
        }
        
        sleep(2)
        
        // Like or Dislike
        let closeButton = app.buttons["btnLike"]
        closeButton.tap()
        
        sleep(4)
        
        // Back
        let back = app.navigationBars.buttons.element(boundBy: 0)
        back.tap()
        
        sleep(4)
        
        // ScrollBack
        for _ in 0..<5 {
            collectionView.swipeDown()
            sleep(1)
        }
        
        
    }
}

extension XCTestCase {
    func wait(forElement element: XCUIElement, timeout: TimeInterval) {
        let predicate = NSPredicate(format: "exists == 1")

        // This will make the test runner continously evalulate the
        // predicate, and wait until it matches.
        expectation(for: predicate, evaluatedWith: element)
        waitForExpectations(timeout: timeout)
    }
    
    func getVisibleCellsQuantity()-> Int {
        var visibleCount = 0
        var isInitialCellVisible = true
        let cells = XCUIApplication().collectionViews.cells
        
        for i in 0...cells.count {
            let cell = cells.element(boundBy: i)
            if cell.exists, !cell.isHittable {
                if i == 0 || !isInitialCellVisible {
                    isInitialCellVisible = false
                } else {
                    return visibleCount
                }
            } else {
                isInitialCellVisible = true
                visibleCount += 1
            }
        }
        return visibleCount
    }
    
}
