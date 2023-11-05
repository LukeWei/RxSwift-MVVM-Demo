//
//  RmdArticleViewController.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/11/3.
//

import UIKit
import RxSwift
import RxCocoa

final class RmdArticleViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: RmdArticleViewModeling = RmdArticleViewModel()
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
    }
    
    func config(targetDisplayName: String) {
        viewModel.targetSubredditDisplayName.accept(targetDisplayName)
    }
    
    private func configTableView() {
        tableView.regiter(RmdArticleCell.self)
        
        viewModel.subreddit
            .map({ $0.data.children })
            .bind(to: tableView.rx.items(cellIdentifier: RmdArticleCell.reuseIdentifier, cellType: RmdArticleCell.self)) {row, subredditChildren, cell in
                // TODO: Duplicated loading issue
                cell.articleImageView.loadFrom(subredditChildren.thumbnail)
            }.disposed(by: disposeBag)
    }

}
