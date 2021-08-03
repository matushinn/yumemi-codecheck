//
//  DetailRepoManager.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/08/03.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol DetailRepoManagerDelegate {
    func didUpdateDetailRepo(_ detailRepoManager:DetailRepoManager,detail:DetailRepoModel)
}

struct DetailRepoManager {
    
    var delegate:DetailRepoManagerDelegate?
    
    func setData(index:Int,repos:[[String:Any]]) {
    
        let repository = repos[index]
        
        if let lan = repository["language"] as? String,let stars = repository["stargazers_count"] as? Int,let watchers = repository["watchers_count"] as? Int,let forks = repository["forks_count"] as? Int,let issues = repository["open_issues_count"] as? Int,let full = repository["full_name"] as? String,let owner = repository["owner"] as? [String: Any]{
            
        
            if let url = owner["avatar_url"] as? String {
                
                //構造体にDetailRepoViewControllerに必要な変数をまとめた
                let detailRepoModel = DetailRepoModel(language: lan, starsCount: stars, watchersCount: watchers, forksCount: forks, issuesCount: issues, fullName: full,owner: owner, urlString: url)
                
                self.delegate?.didUpdateDetailRepo(self, detail: detailRepoModel)
               
            }
        }
    }
}
