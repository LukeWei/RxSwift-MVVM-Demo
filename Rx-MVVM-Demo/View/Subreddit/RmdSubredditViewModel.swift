//
//  RmdSubredditViewModel.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/10/29.
//

import Foundation
import RxSwift
import RxCocoa

protocol RmdSubredditViewModeling {
    var subredditChildrens: BehaviorRelay<[SubredditChildren]> { get }
    func fetchSubreddit()
}

final class RmdSubredditViewModel: RmdSubredditViewModeling {
    
    // output
    var subredditChildrens: BehaviorRelay<[SubredditChildren]> = .init(value: [SubredditChildren]())
    
    private var subredditChildrenSubject = PublishSubject<[SubredditChildren]>()
    private var disposedBag = DisposeBag()
    
    init() {}
    
    func fetchSubreddit() {
        RmdSubredditApiManager().fetch()
            .asObservable()
            .map({ $0.data.childrens })
            .subscribe { [weak self] subredditChildrens in
                self?.subredditChildrens.accept(subredditChildrens)
            }.disposed(by: disposedBag)            
    }
}
