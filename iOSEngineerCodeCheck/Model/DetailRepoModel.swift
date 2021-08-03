//
//  DetailRepoModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/08/03.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

struct DetailRepoModel {
    let language:String
    let starsCount:Int
    let watchersCount:Int
    let forksCount:Int
    let issuesCount:Int
    let fullName:String
    let owner:[String:Any]
    let urlString:String
    
    
}
