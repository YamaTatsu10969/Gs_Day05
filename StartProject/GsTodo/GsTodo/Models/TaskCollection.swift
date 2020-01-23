//
//  TaskCollection.swift
//  GsTodo
//
//  Created by yamamototatsuya on 2020/01/15.
//  Copyright © 2020 yamamototatsuya. All rights reserved.
//

import Foundation

protocol TaskCollectionDelegate: class {
    func saved()
}

class TaskCollection {
    //初回アクセスのタイミングでインスタンスを生成
    static var shared = TaskCollection()
    //外部からの初期化を禁止
    private init(){}
    
    //外部からは参照のみ許可 // ここに全ての情報が持っている！！！
    private(set) var tasks: [Task] = []
    //弱参照して循環参照を防ぐ
    weak var delegate: TaskCollectionDelegate? = nil
    
    func addTask(_ task: Task) {
        tasks.append(task)
        save()
    }
    
    func editTask() {
        save()
    }
    
    func removeTask(index: Int) {
        tasks.remove(at: index)
        save()
    }
    
    func getTask(index: Int) -> Task {
        return tasks[index]
    }
    
    func save() {
        delegate?.saved()
    }
}
