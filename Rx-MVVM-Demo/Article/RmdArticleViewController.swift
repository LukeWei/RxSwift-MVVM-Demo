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
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
    }
    
    func config(targetDisplayName: String) {
        title = targetDisplayName
        viewModel.targetSubredditDisplayName.accept(targetDisplayName)
    }
    
    private func configTableView() {
        let viewModel: RmdArticleViewModeling = viewModel
        let tableView: UITableView = tableView
                
        tableView.regiter(RmdArticleCell.self)
        tableView.allowsSelection = false
        
        viewModel.subreddit
            .map({ $0.data.childrens })
            .bind(to: tableView.rx.items(cellIdentifier: RmdArticleCell.reuseIdentifier, cellType: RmdArticleCell.self)) {row, subredditChildren, cell in
                cell.articleTitleLabel.text = subredditChildren.title
                cell.articleImageView.kf.setImage(with: URL(string: subredditChildren.thumbnail))
            }.disposed(by: disposeBag)
        
        tableView.rx.contentOffset
            .asDriver()
            .drive { _ in
                // TODO: Duplicate load issue
                guard tableView.isNearBottomEdge() else { return }
                viewModel.fetchMore(after: viewModel.subreddit.value.data.after)
            }.disposed(by: disposeBag)
        
    }
}
