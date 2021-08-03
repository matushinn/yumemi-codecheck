//
//  SearchRepoViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/08/02.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchRepoViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!{
        didSet {
            searchBar.placeholder = "Githubリポジトリを検索"
            searchBar.delegate = self
        }
    }
    
    @IBOutlet var tableView: UITableView!
    
    var repositories = [[String:Any]]()
    
    var index = 0
    
    var repositoryManager = RepositoryManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repositoryManager.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            let detailVC = segue.destination as! DetailRepoViewController
            detailVC.repo = repositories
            detailVC.index = index
        }
    }
    
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension SearchRepoViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Repository", for: indexPath)
        let rp = repositories[indexPath.row]
    
        if let fullName =  rp["full_name"] as? String{
            cell.textLabel?.text = fullName
        }
        if let language =  rp["language"] as? String{
            cell.detailTextLabel?.text = language
        }
        
        
        cell.tag = indexPath.row
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        index = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
        
    }
}

//MARK: - UISearchBarDelegate
extension SearchRepoViewController : UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //　テキスト変更中は何も表示させない(初期化)
        repositories = []
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let repository = searchBar.text {
            repositoryManager.fetchRepositoory(repositoryName:repository)
        }
        
    }
}

//MARK: - RepositoryManagerDelegate
extension SearchRepoViewController : RepositoryManagerDelegate {
    func didUpdateRepository(_ repositoryManager: RepositoryManager, repository: [[String:Any]]) {
        DispatchQueue.main.async {
        
            self.repositories = repository
            // print(self.repo[0]["full_name"])
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
