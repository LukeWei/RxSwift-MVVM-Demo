//
//  RmdArticleCell.swift
//  Rx-MVVM-Demo
//
//  Created by Luke Lin on 2023/11/3.
//

import UIKit

final class RmdArticleCell: UITableViewCell {
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
