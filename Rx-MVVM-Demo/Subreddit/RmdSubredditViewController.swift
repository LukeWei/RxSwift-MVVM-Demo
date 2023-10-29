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
        
        tableView.regiter(RmdSubredditCell.self)
        
        viewModel.updateSubreddit
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] shouldUpdate in
                guard shouldUpdate else { return }
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)

        viewModel.subredditChildren
            .bind(to: tableView.rx.items(cellIdentifier: RmdSubredditCell.reuseIdentifier, cellType: RmdSubredditCell.self)) { (row, subredditChildren, cell) in
                cell.textLabel?.text = subredditChildren.displayName
            }.disposed(by: disposeBag)
        
        viewModel.fetchSubreddit()
    }

}
