//
//  RepositoryManager.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/08/02.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import Alamofire

protocol RepositoryManagerDelegate {
    func didUpdateRepository(_ repositoryManager:RepositoryManager,repository:[[String:Any]])
    func didFailWithError(error:Error)
}


struct RepositoryManager {
    let repositoryURL = "https://api.github.com/search/repositories"
    
    var delegate:RepositoryManagerDelegate?
    
    func fetchRepositoory(repositoryName:String){
        if repositoryName.count != 0 {
            let urlString = "\(repositoryURL)?q=\(repositoryName)"
            
            print(urlString)
            
            self.performRequest(with: urlString)
        }
        
    }
    func performRequest(with urlString:String){
        
        if let url = URL(string: urlString) {
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
                
                switch response.result{
                case .success:
                    guard let safeData = response.data else{
                        return
                    }
                    if let obj = try! JSONSerialization.jsonObject(with: safeData) as? [String: Any] {
                        if let items = obj["items"] as? [[String: Any]] {
                            self.delegate?.didUpdateRepository(self, repository: items)
                        }
                    }
                    
                case .failure(_):
                    break
                }
            }
        }
        
    }
    
    
}
