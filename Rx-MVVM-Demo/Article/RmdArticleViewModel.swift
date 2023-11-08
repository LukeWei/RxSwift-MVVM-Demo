//
//  RmdArticleViewModel.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/11/4.
//

import Foundation
import RxSwift
import RxCocoa

protocol RmdArticleViewModeling {
    var subreddit: BehaviorRelay<Subreddit> { get }
    var targetSubredditDisplayName: BehaviorRelay<String> { get set }
    
    func fetchMore(after: String) -> Observable<Subreddit>
}

final class RmdArticleViewModel: RmdArticleViewModeling {
    
    var subreddit: BehaviorRelay<Subreddit> = .init(value: Subreddit())
    var targetSubredditDisplayName: BehaviorRelay<String> = .init(value: "")
    
    private var disposeBag = DisposeBag()
    
    init() {
        targetSubredditDisplayName.asObservable()
            .flatMap { displayName in
                RmdArticleAPIManager().fetch(subredditDisplayName: displayName)
            }.subscribe { [weak self] subreddit in
                self?.subreddit.accept(subreddit)
            }.disposed(by: disposeBag)
    }
    
    func fetchMore(after: String) -> Observable<Subreddit> {
        RmdArticleAPIManager().fetch(subredditDisplayName: targetSubredditDisplayName.value, after: after)
    }
}
