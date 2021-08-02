//
//  RepositoryData.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/08/02.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

struct RepositoryData:Codable{
    let items:[Items]
    
}

struct Items:Codable {
    let full_name:String
    let language:String
    
}
