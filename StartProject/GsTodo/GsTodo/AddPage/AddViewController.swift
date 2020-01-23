//
//  AddViewController.swift
//  GsTodo
//
//  Created by yamamototatsuya on 2020/01/15.
//  Copyright © 2020 yamamototatsuya. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    // # 手順
    // 1. UIを作成する。
    // label + textField + label + textView
    // 2. textView の UI を追加(boarder, cornerRadius)
    // 3. 2 をメソッド化する
    // 4. navigationBar に rightBarButtonItem を追加する(title は "Save", style = .plain, target = self, action = nil)
    // 5.
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    
    var selectedTask: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMemoTextView()
        setupNavigationBar()
        
        if let selectedTask = selectedTask {
            title = "編集"
            titleTextField.text = selectedTask.title
            memoTextView.text = selectedTask.memo
        }
    }
    
    // MARK: Setup
    fileprivate func setupMemoTextView() {
        memoTextView.layer.borderWidth = 1
        memoTextView.layer.borderColor = UIColor.lightGray.cgColor
        memoTextView.layer.cornerRadius = 3
    }
    
    fileprivate func setupNavigationBar() {
        title = "Add"
        let rightButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tapSaveButton))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    
    // MARK: Other Method
    @objc func tapSaveButton() {
        print("Saveボタンを押したよ！")
        
        guard let title = titleTextField.text else {
            return
        }
        
        if title.isEmpty {
            print(title, "👿titleが空っぽだぞ〜")
            showAlert("👿 タイトルが入力されていません！！！")
            return // return を実行すると、このメソッドの処理がここで終了する。
        }
        
        // ここで Edit か Add　かを判定している
        if let selectedTask = selectedTask {
            // こっちは Edit
            selectedTask.title = title
            TaskCollection.shared.editTask()
        } else {
            // Add
            let task = Task(title: title)
            TaskCollection.shared.addTask(task)
        }
        
        // 前の画面に戻る
        navigationController?.popViewController(animated: true)
    }
    
    // アラートを表示するメソッド
    func showAlert(_ text: String){
        let alertController = UIAlertController(title: "エラー", message: text , preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
}




// TODO: アクセス修飾子の説明。質問があったら。
// private, public, internal(デフォルトではこれ)

//
//class Test {
//    func showAddViewController() {
//        let vc = AddViewController()
//        vc.memoTextView
//
//        // private にしてみる
//        vc.setupMemoTextView()
//    }
//
//}
