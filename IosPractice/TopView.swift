//
//  TopView.swift
//  IosPractice
//
//  Created by kkkkan on 2021/05/23.
//

import SwiftUI


struct TopView: View {
    @EnvironmentObject var model :Model
    @EnvironmentObject var apiModel :ApiModel
    //    @State var isDataLoaded = false
    var memos : Array<Memo> = []
    
    
    var body: some View {
        VStack{
            
            if(self.apiModel.isLoaded){
                // コンテンツを読んでき終わったら表示
                MemoList(memos: self.apiModel.memos)
            }
        }
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                // 一秒後の遅延処理
                //                let contetn1=["a","b","c"]
                //                let content2=["1","2","3"]
                //                self.model.setMemos(memos:[Memo(title:"タイトル1",content: contetn1),Memo(title:"タイトル2",content: content2)] )
            }
        }
    }
}


struct MemoList:View {
    var memos : Array<Memo>
    init(memos : Array<Memo>) {
        self.memos = memos
    }
    var body: some View{
        ScrollView(.vertical){
            VStack{
                ForEach(self.memos, id: \.self){ memo in
                    CardView(title: memo.title, contents: memo.content)
                }
            }
        }
    }
}

struct Memo : Hashable ,Decodable, Identifiable{
    let id=UUID() // warningが出ているけど、letにしておかないとAPI呼び出し後にJSONにパースするところで落ちる
    var title : String
    var content : Array<String>
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
