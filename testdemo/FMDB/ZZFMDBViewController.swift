//
//  ZZFMDBViewController.swift
//  testdemo
//
//  Created by 崽崽 on 2018/6/8.
//  Copyright © 2018年 zaizai. All rights reserved.
//

import UIKit
class ZZFMDBViewController: ZZBaseViewController {
    
    
    var dbs = ZZFMDBManager.getData(tableName: "testdemo", condition: nil)
    let tableView = UITableView(frame: ZZRect)
    let reuseIdentifer = "DBTableCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func setupView() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addUser))
        title = "数据列表"
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
    }
    
    
    @objc func addUser() {
        
        let alert = UIAlertController(title: "添加用户", message: "输入用户，密码！", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let delete = UIAlertAction(title: "确定", style: .destructive, handler: { (action) in
            let name = alert.textFields?[0].text
            let password = alert.textFields?[1].text
            if (name?.characters.count)! < 1 || (password?.characters.count)! < 1 {
                return
            }
            let dic = ["name":name, "password":password]
            self.dbs?.append(dic as! [String : String])
            self.tableView.reloadData()
            ZZFMDBManager.saveData(tableName: "test", key_value_dic: dic as! Dictionary<String, String>)
        })
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "输入用户名："
            textField.clearButtonMode = .whileEditing
        })
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "输入密码："
            textField.clearButtonMode = .whileEditing
        })
        alert.addAction(cancel)
        alert.addAction(delete)
        self.present(alert, animated: true, completion: nil)
    }
}


extension ZZFMDBViewController:UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dbs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer) ?? UITableViewCell(style: .value1, reuseIdentifier: reuseIdentifer)
        let dic = dbs![indexPath.row]
        cell.textLabel?.text = "用户名：" + dic["name"]!
        cell.detailTextLabel?.text = "密码：" + dic["password"]!
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight(rawValue: 5))
        cell.textLabel?.textColor = .orange
        return cell
    }
    
    
    //MARK: - Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "删除") { (action, index) in
            print("删除")
            let alert = UIAlertController(title: "是否删除?", message: "删除了就没有了哟！", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
                tableView.reloadRows(at: [indexPath], with: .fade)
            })
            let delete = UIAlertAction(title: "确定", style: .destructive, handler: { (action) in
                let dic = self.dbs?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                ZZFMDBManager.deleteData(tableName: "test", condition: "name = '\((dic?["name"])!)'")
            })
            alert.addAction(cancel)
            alert.addAction(delete)
            self.present(alert, animated: true, completion: nil)
        }
        delete.backgroundColor = .red
        
        return [delete]
    }
}

