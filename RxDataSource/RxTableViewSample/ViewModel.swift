//
//  ViewModel.swift
//  RxTableViewSample
//
//  Created by gibong.kim.ts on 2017/08/23.
//  Copyright © 2017年 キム ギボン. All rights reserved.
//

import Foundation
import RxSwift

protocol ViewModelType {
    
    var inputs: ViewModelInputs { get }
    var outputs: ViewModelOutputs { get }
}

protocol ViewModelInputs {
    func fetch() -> Bool
    func willDisplayRow(current: Int, totalCount: Int)
}

protocol ViewModelOutputs {
    var items: Variable<[String]> { get }
}


final class ViewModel: ViewModelType, ViewModelInputs, ViewModelOutputs {
    var items: Variable<[String]>
    
    var inputs: ViewModelInputs { return self }
    var outputs: ViewModelOutputs { return self }
    
    private var isShow = false
    private let dummy: [String] = [
        "hoge",
        "foo",
        "hogehoge",
        "foofoo",
        "hogehogehoge",
        "foofoofoo",
        "hogehogehogehoge",
        "foofoofoofoo",
        "hogehogehogehogehoge",
        "foofoofoofoofoo",
        "hogehogehogehogehogehoge",
        "foofoofoofoofoofoo",
        "hogehogehogehogehogehogehoge",
        "foofoofoofoofoofoofoo",
        "hogehogehogehogehogehogehogehoge",
        "foofoofoofoofoofoofoofoo"
    ]
    
    public init() {
        
        self.items = Variable<[String]>.init([])
    }
    func fetch() -> Bool {
        isShow = !isShow
        
        self.items.value = isShow ? dummy : []
        return isShow
    }
    
    func willDisplayRow(current: Int, totalCount: Int) {
        
        if totalCount > 8 && current > totalCount - 3 {
            self.items.value += dummy
        }
    }

}
