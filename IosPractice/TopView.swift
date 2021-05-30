//
//  TopView.swift
//  IosPractice
//
//  Created by kkkkan on 2021/05/23.
//

import SwiftUI


struct TopView: View {
    @EnvironmentObject var model :Model
    @StateObject var apiModel :ApiModel // EnvironmentObjectだと、bodyが更新されると寿命が終わるらしい。
    // https://zenn.dev/hirothings/scraps/b29b2a8bc7f30f
    
    
    var body: some View {
        VStack{
            if(self.apiModel.memos.count>0){
                MemoList(memos: self.apiModel.memos).environmentObject(apiModel)
            }else{
                EmptyView()
            }
        }
        .coordinateSpace(name: "parent")
        .onAppear(){
            // 表示したら読み込み開始
            self.apiModel.load()
        }
    }
}


struct  MemoList:View {
    var memos : Array<Memo>
    @EnvironmentObject var apiModel :ApiModel
    
    init(memos : Array<Memo>) {
        self.memos = memos
    }
    
    var body: some View{
        var swipe : SwipeRefreshController?
        
        // 中間橋渡しをしてくれるオブジェクトを作ることで、データが更新されたらクルクルを消せるようにする。
        let p = Binding<Array<Memo>>(get : {
            return self.apiModel.memos
        },set : { memos in
            swipe?.finishRefresh() // データ取得が終わったのでクルクルを止める
            self.apiModel.memos = memos
            
        })
        
        swipe = SwipeRefreshController(coordinateSpaceName:"parent"){
            self.apiModel.load(memosContainer: p)
        }
        
        return ScrollView(.vertical){
            VStack{
                swipe
                
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
        TopView(apiModel: ApiModel())
    }
}
