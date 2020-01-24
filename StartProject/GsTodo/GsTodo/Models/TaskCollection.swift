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
    func loaded()
}

class TaskCollection {
    //初回アクセスのタイミングでインスタンスを生成
    static var shared = TaskCollection()
    //外部からの初期化を禁止
    private init(){}
    
    //外部からは参照のみ許可 // ここに全ての情報が持っている！！！
    private(set) var tasks: [Task] = []
    
    // UserDefaults に使うキー
    let userDefaultsTasksKey = "user_tasks"
    
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
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(tasks)
            UserDefaults.standard.set(data, forKey: userDefaultsTasksKey)
        } catch {
            print(error)
        }
        delegate?.saved()
    }
    
    func load() {
        let decoder = JSONDecoder()
        do {
            guard let data = UserDefaults.standard.data(forKey: userDefaultsTasksKey) else {
                return
            }
            tasks = try decoder.decode([Task].self, from: data)
        } catch {
            print(error)
        }
        delegate?.loaded()
    }
}
