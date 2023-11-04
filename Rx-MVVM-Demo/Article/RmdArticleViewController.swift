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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
    }
    
    private func configTableView() {
        tableView.regiter(RmdArticleCell.self)
        
    }

}
