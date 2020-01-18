//
//  Task.swift
//  GsTodo
//
//  Created by yamamototatsuya on 2020/01/15.
//  Copyright © 2020 yamamototatsuya. All rights reserved.
//

import Foundation

// Task のクラス。
// プロパティに title と memo を持っている
class Task {
    var title: String
    var memo: String?
    
    // init とは、Task を作るときに呼ばれるメソッド。(イニシャライザという)
    init(title: String) {
        self.title = title
    }
}
