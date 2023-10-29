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
    var subredditChildren: Observable<[SubredditChildren]> { get }
    var updateSubreddit: PublishSubject<Bool> { get }
    func fetchSubreddit()
}

final class RmdSubredditViewModel: RmdSubredditViewModeling {
    
    // output
    let updateSubreddit: PublishSubject = PublishSubject<Bool>()
    var subredditChildren: Observable<[SubredditChildren]>
    
    private var subredditChildrenSubject = PublishSubject<[SubredditChildren]>()
    private var disposedBag = DisposeBag()
    
    init() {
        subredditChildren = subredditChildrenSubject.asObservable()
    }
    
    func fetchSubreddit() {
        RmdSubredditApiManager().fetch()
            .asObservable()
            .map({ $0.data.children })
            .subscribe { [weak self] subredditChildren in
                self?.subredditChildrenSubject.onNext(subredditChildren)
                self?.updateSubreddit.onNext(true)
            }.disposed(by: disposedBag)            
    }
}
