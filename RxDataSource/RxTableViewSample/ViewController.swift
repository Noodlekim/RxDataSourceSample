//
//  ViewController.swift
//  RxTableViewSample
//
//  Created by gibong.kim.ts on 2017/08/23.
//  Copyright © 2017年 キム ギボン. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


// 参照: http://qiita.com/hironytic/items/71bc729abe73ab9f0879
class ItemListViewCell: UITableViewCell { }

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModel()
    let dataSource = DataSource.init(identifier: "cell")
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        
        // ボタンタップによるデータ更新
        button.rx.controlEvent(.touchUpInside).asObservable()
            .subscribe(onNext: { (_) in
                let isSetData = self.viewModel.fetch()
                self.button.setTitle(isSetData ? "Clear" : "setData", for: UIControlState.normal)
            })
            .addDisposableTo(bag)
        
        // テーブルビュー更新
        viewModel.outputs.items.asObservable()
            .bind(to: tableView.rx.items(dataSource: self.dataSource))
            .addDisposableTo(bag)
    }

}

extension ViewController: UITableViewDelegate {
    // TODO: 高さ事項計算されるように
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        viewModel.willDisplayRow(current: indexPath.row, totalCount: dataSource.totalItemsCount)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            let item = try dataSource.model(at: indexPath)
            print("selected item \(item)")
        } catch { }
    }
}
