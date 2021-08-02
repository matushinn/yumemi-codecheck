//
//  SearchRepoViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/08/02.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchRepoViewController: UITableViewController, UISearchBarDelegate ,RepositoryManagerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var repo: [[String: Any]]=[]
    
    var task: URLSessionTask?
    var word: String!
    var url: String!
    var index: Int!
    
    var repositoryManager = RepositoryManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.placeholder = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
        
        repositoryManager.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let repository = searchBar.text {
            repositoryManager.fetchRepositoory(repositoryName:repository)
        }
        
    }
    func didUpdateRepository(_ repositoryManager: RepositoryManager, repository: [[String : Any]]) {
        DispatchQueue.main.async {
        
            self.repo = repository
            // print(self.repo[0]["full_name"])
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            let detailVC = segue.destination as! DetailRepoViewController
            detailVC.vc1 = self
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let rp = repo[indexPath.row]
    
        if let fullName =  rp["full_name"] as? String{
            cell.textLabel?.text = fullName
        }
        if let language =  rp["language"] as? String{
            cell.detailTextLabel?.text = language
        }
        
        
        cell.tag = indexPath.row
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        index = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
        
    }
    
}



