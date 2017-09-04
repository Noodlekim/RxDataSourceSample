//
//  DataSource.swift
//  RxTableViewSample
//
//  Created by gibong.kim.ts on 2017/08/23.
//  Copyright © 2017年 キム ギボン. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


// TODO: RxTableViewDataSourceType

extension DataSource: RxTableViewDataSourceType {
    
    typealias Element = [String]
    
    func tableView(_ tableView: UITableView, observedEvent: Event<Element>) -> Void {
        
        UIBindingObserver(UIElement: self) { (dataSource, element) in
            dataSource.items = element
            tableView.reloadData()
            }
            .on(observedEvent)
    }
}

protocol DataSourceType {
    var cellIdentifier: String { get }
    var totalItemsCount: Int { get }
}

class DataSource: NSObject, DataSourceType {

    // DataSourceType
    internal var cellIdentifier: String
    var totalItemsCount: Int {
        return items.count
    }

    // init
    fileprivate var items: Element = []

    init(identifier: String) {
        cellIdentifier = identifier
    }

}


// MARK: - UITableViewDataSource

extension DataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = item
        return cell
    }
}

// TODO: カスタマイズ(out of index, not exsitなど)
extension DataSource: SectionedViewDataSourceType {
    
    func model(at indexPath: IndexPath) throws -> Any {
        return items[indexPath.row]
    }
}
