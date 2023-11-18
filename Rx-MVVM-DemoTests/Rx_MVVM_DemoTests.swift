//
//  Rx_MVVM_DemoTests.swift
//  Rx-MVVM-DemoTests
//
//  Created by Luke Lin on 2023/10/28.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Rx_MVVM_Demo

final class Rx_MVVM_DemoTests: XCTestCase {

    private let bag = DisposeBag()
    private var articleVM: RmdArticleViewModeling!
    
    override func setUpWithError() throws {
        articleVM = RmdArticleViewModel()
    }

    override func tearDownWithError() throws {}

    func testArticleViewModelDisplayContent() throws {
        let displayName = "sports"
        let exp = expectation(description: "Article View Model display content")
        
        articleVM.subreddit
            .subscribe(onNext: { subreddit in
                if subreddit.data.childrens.first?.subreddit == displayName {
                    exp.fulfill()
                }
            }).disposed(by: bag)
        
        articleVM.targetSubredditDisplayName.accept(displayName)
        
        wait(for: [exp], timeout: 5)
    }

    func testMutableUtility() {
        struct TestData: Mutable {
            var value: Int
        }
        
        let value: Int = 1
        let newValue: Int = 2
        
        var data = TestData(value: value)
        data = data.mutate {
            $0.value = newValue
        }
        
        XCTAssert(data.value == newValue)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
