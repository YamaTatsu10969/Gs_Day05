//
//  TaskListViewController.swift
//  GsTodo
//
//  Created by yamamototatsuya on 2020/01/15.
//  Copyright © 2020 yamamototatsuya. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // この ViewController で delegate のメソッドを使うために記述している。
        tableView.delegate = self
        // この ViewController で datasouce のメソッドを使うために記述している。
        tableView.dataSource = self
        // nib と xib はほぼ一緒
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        // tableView に使う xib ファイルを登録している。
        tableView.register( nib, forCellReuseIdentifier: "CustomCell")
        
        // デリゲートのメソッドを使うために記述している。
        TaskCollection.shared.delegate = self
        
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    // MARK: UITableView
    
    /// 1つの Section の中の Row　の数を定義する(セルの数を定義)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskCollection.shared.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 登録したセルを使う。 as! CustomCell としないと、UITableViewCell のままでしか使えない。
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.titleLabel?.text = TaskCollection.shared.tasks[indexPath.row].title
        return cell
    }
    
    fileprivate func setupNavigationBar() {
        let rightButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddScreen))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func showAddScreen() {
        let vc = AddViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension TaskListViewController: TaskCollectionDelegate {
    // デリゲートのメソッド
    func reload() {
        // tableView をリロードして、画面を更新する。
        tableView.reloadData()
    }
}
