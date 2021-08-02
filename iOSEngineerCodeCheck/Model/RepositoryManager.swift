//
//  RepositoryManager.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/08/02.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol RepositoryManagerDelegate {
    func didUpdateRepository(_ repositoryManager:RepositoryManager,repository:[[String:Any]])
    func didFailWithError(error:Error)
}


struct RepositoryManager {
    let repositoryURL = "https://api.github.com/search/repositories"
    
    var delegate:RepositoryManagerDelegate?
    
    var temp: [[String: Any]]=[]
    
    
    func fetchRepositoory(repositoryName:String){
        if repositoryName.count != 0 {
            let urlString = "\(repositoryURL)?q=\(repositoryName)"
            
            print(urlString)
            
            self.performRequest(with: urlString)
        }
        
    }
    func performRequest(with urlString:String){
        //①Create a URL
        if let url = URL(string: urlString){
            //②Create a URL Session
             let session = URLSession(configuration: .default)
            
            //③Give the sessin Task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    // print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                                
                if let safeData = data {
                    if let obj = try! JSONSerialization.jsonObject(with: safeData) as? [String: Any] {
                        if let items = obj["items"] as? [[String: Any]] {
                            self.delegate?.didUpdateRepository(self, repository: items)
                            
                        }
                    }
                    
                }
            }
            
            //④Start the task
            task.resume()
        }
        
    }
    
    
}
