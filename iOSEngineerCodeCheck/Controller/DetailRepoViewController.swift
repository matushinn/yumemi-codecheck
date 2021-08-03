//
//  DetailRepoViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/08/02.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit
import SDWebImage

class DetailRepoViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var issuesCountLabel: UILabel!
    
    var detailRepoManager = DetailRepoManager()
    
    var repo = [[String:Any]]()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailRepoManager.delegate = self
        detailRepoManager.setData(index:index,repos: repo)
        
    }
    
}

//MARK: - DetailRepoManagerDelegate
extension DetailRepoViewController:DetailRepoManagerDelegate{
    
    func didUpdateDetailRepo(_ detailRepoManager: DetailRepoManager, detail: DetailRepoModel) {
        self.languageLabel.text = "Written in " + detail.language
        self.starsCountLabel.text = "\(String(detail.starsCount)) stars"
        self.watchersCountLabel.text = "\(String(detail.watchersCount)) watchers"
        self.forksCountLabel.text = "\(String(detail.forksCount)) forks"
        self.issuesCountLabel.text = "\(String(detail.issuesCount)) open issues"
        self.titleLabel.text = detail.fullName
        
        self.profileImageView.sd_setImage(with: URL(string: detail.urlString), completed: nil)
    }
    
}
