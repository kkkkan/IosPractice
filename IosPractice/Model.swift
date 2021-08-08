//
//  File.swift
//  IosPractice
//
//  Created by kkkkan on 2021/05/22.
//

import SwiftUI

class Model: ObservableObject {
    @Published var secondViewPushed = false
    @Published var memos : Array<Memo> = []
    @Published var isDataLoaded = false

    func setMemos(memos : Array<Memo>) -> () {
        self.memos = memos
        self.isDataLoaded=true
    }
    
}
