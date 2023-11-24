//
//  RmdArticleViewController.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/11/3.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class RmdArticleViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: RmdArticleViewModeling = RmdArticleViewModel()
    
    private var shouldFetchMoreData = true
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
    }
    
    func config(targetDisplayName: String) {
        viewModel.targetSubredditDisplayName.accept(targetDisplayName)
    }
    
    private func configTableView() {
                
        tableView.register(RmdArticleCell.self)
        tableView.allowsSelection = false
        
        viewModel.subreddit
            .map({ $0.data.childrens })
            .bind(to: tableView.rx.items(cellIdentifier: RmdArticleCell.reuseIdentifier, cellType: RmdArticleCell.self)) {row, subredditChildren, cell in
                cell.articleTitleLabel.text = subredditChildren.title
                cell.articleImageView.kf.setImage(with: URL(string: subredditChildren.thumbnail))
            }.disposed(by: disposeBag)
        
        viewModel.subreddit
            .asDriver()
            .filter({ !$0.data.after.isEmpty })
            .drive(onNext: { [weak self] subreddit in
                guard let strongSelf = self else { return }
                if !strongSelf.shouldFetchMoreData {
                    strongSelf.shouldFetchMoreData = true
                }
            }).disposed(by: disposeBag)
        
        tableView.rx.contentOffset
            .asDriver()
            .map({ $0.y })
            .filter({ $0 > 0 })
            .drive { [weak self] _ in
                guard let strongSelf = self, strongSelf.tableView.isNearBottomEdge() && strongSelf.shouldFetchMoreData else { return }
                
                strongSelf.shouldFetchMoreData = false
                strongSelf.viewModel.fetchMore(after: strongSelf.viewModel.subreddit.value.data.after)
            }.disposed(by: disposeBag)
        
    }
}
