//
//  ListTableViewController.swift
//  通讯录-Swift
//
//  Created by yangfan on 2017/12/26.
//  Copyright © 2017年 yangfan. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    // 全局数组：数据源
    var arrayPerson = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 加载数据，尾随闭包，在闭包中刷新表格
        loadData { data in

            self.arrayPerson += data

            self.tableView.reloadData()
        }
    }

    private func loadData(completion: @escaping (_ data: [Person]) -> Void) {
        // 模拟异步加载
        DispatchQueue.global().async {
            print("正在加载数据")

            Thread.sleep(forTimeInterval: 1)

            var arrayTemp = [Person]()

            for i in 0 ..< 20 {
                let p: Person = Person()

                p.name = "yangfan -\(i)"
                p.phone = "181" + String(format: "%08d", arc4random_uniform(100000000))

                p.address = "AnHuiWuhu"

                arrayTemp.append(p)
            }

            // 主线程更新UI
            DispatchQueue.main.async {
                completion(arrayTemp)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPerson.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath)

        cell.textLabel?.text = arrayPerson[indexPath.row].name

        cell.detailTextLabel?.text = arrayPerson[indexPath.row].phone

        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        performSegue(withIdentifier: "list2details", sender: indexPath)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailsTableViewController

        // 修改
        if let indexPath = sender as? IndexPath {
            vc.person = arrayPerson[indexPath.row]

            // 编辑完成的闭包
            vc.completionCallBack = {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }

        // 添加
        else {
            vc.completionCallBack = { [weak vc] in

                guard let p = vc?.person else {
                    return
                }

                self.arrayPerson.insert(p, at: 0)

                self.tableView.reloadData()
            }
        }
    }
}
