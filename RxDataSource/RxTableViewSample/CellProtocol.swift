//
//  CellProtocol.swift
//  RxTableViewSample
//
//  Created by gibong.kim.ts on 2017/08/23.
//  Copyright © 2017年 キム ギボン. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

protocol CellReusable {
    
    static var identifier: String { get }
}

extension CellReusable where Self: UITableView {
    static var identifier: String {
        return String(describing: self)
    }
}

//Reactive(BaseがUITableView)に対してextensionを追加する
extension Reactive where Base: UITableView {
    
    func items<S: Sequence, Cell: UITableViewCell, O: ObservableType>(_ cellType: Cell.Type)
        -> (_ source: O)
        -> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
        -> Disposable
        where O.E == S, Cell: CellReusable {
            return items(cellIdentifier: cellType.identifier, cellType: cellType)
    }
}
