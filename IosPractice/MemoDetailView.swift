//
//  MemoDetailView.swift
//  IosPractice
//
//  Created by kkkkan on 2021/06/13.
//

import SwiftUI

// メモ詳細表示画面
struct  MemoDetailView:View {
    var memo : Memo
    
    
    init(memo : Memo) {
        self.memo = memo
    }
    
    var body: some View{
        return ScrollView(.vertical){
            VStack{
                Text(self.memo.title)
                    .font(.bold(.title)())
                    .padding()
                    .frame(maxWidth: .infinity,alignment : Alignment.leading)
                
                ForEach(self.memo.content,id: \.self){ c in
                    Text(c)
                        .padding().frame(maxWidth: .infinity,alignment : Alignment.leading)
                }
            }
        }
    }
}
