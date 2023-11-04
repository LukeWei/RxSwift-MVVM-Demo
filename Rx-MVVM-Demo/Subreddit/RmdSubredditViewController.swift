//
//  RmdSubredditViewController.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/10/28.
//

import UIKit
import RxSwift
import RxCocoa

class RmdSubredditViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: RmdSubredditViewModeling = RmdSubredditViewModel()
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        title = "Subreddits"
        
        configTableView()
        
        viewModel.subredditChildren
            .asDriver(onErrorJustReturn: [])
            .drive { [weak self] _ in
                self?.tableView.reloadData()
            }

        viewModel.subredditChildren
            .bind(to: tableView.rx.items(cellIdentifier: RmdSubredditCell.reuseIdentifier, cellType: RmdSubredditCell.self)) { (row, subredditChildren, cell) in
                cell.displayNameLabel.rx.text
                    .asObserver()
                    .onNext(subredditChildren.displayName)
                
            }.disposed(by: disposeBag)
        
        viewModel.fetchSubreddit()
    }

    private func configTableView() {
        tableView.regiter(RmdSubredditCell.self)
        
        tableView.rx.itemSelected
            .subscribe { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
                
                // TODO: Present ArticleView
                let targetVC: RmdArticleViewController = RmdArticleViewController.loadFromNib()
                self?.navigationController?.pushViewController(targetVC, animated: true)
                
            }.disposed(by: disposeBag)
    }
}
