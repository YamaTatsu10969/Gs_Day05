//
//  AddViewController.swift
//  GsTodo
//
//  Created by yamamototatsuya on 2020/01/15.
//  Copyright © 2020 yamamototatsuya. All rights reserved.
//

import UIKit
#warning("ここに PKHUD を import しよう！")
import PKHUD

class AddViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    
    #warning("selectIndex を追加")
    var selectIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMemoTextView()
        setupNavigationBar()
        
        #warning("ここにEditかどうかの判定を入れる")
        if let index = selectIndex {
            title = "編集"
            titleTextField.text = TaskCollection.shared.tasks[index].title
            memoTextView.text = TaskCollection.shared.tasks[index].memo
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
            
            #warning("showAlert を PKHUD に変更しよう！")
            HUD.flash(.labeledError(title: nil, subtitle: "👿 タイトルが入力されていません！！！"), delay: 1)
            // showAlert("👿 タイトルが入力されていません！！！")
            return // return を実行すると、このメソッドの処理がここで終了する。
        }
        
        #warning("ここにEditかどうかの判定を入れる")
        // ここで Edit か Add　かを判定している
        if let index = selectIndex {
            // Edit
            let editTask = Task(title: title, memo: memoTextView.text)
            TaskCollection.shared.editTask(task: editTask, index: index)
        } else {
            // Add
            let task = Task(title: title, memo: memoTextView.text)
            TaskCollection.shared.addTask(task)
        }
        
        #warning("ここにHUD.flash の success を入れる")
        HUD.flash(.success, delay: 0.3)
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
