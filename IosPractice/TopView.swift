//
//  TopView.swift
//  IosPractice
//
//  Created by kkkkan on 2021/05/23.
//

import SwiftUI
import CoreData


struct TopView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Memos.memoTitle, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Memos>
    
    //    @EnvironmentObject var model :Model
    @StateObject var apiModel :ApiModel // EnvironmentObjectだと、bodyが更新されると寿命が終わるらしい。
    // https://zenn.dev/hirothings/scraps/b29b2a8bc7f30f
    
    
    var body: some View {
        var _memos = Array<Memo>()
        self.items.forEach{ memo in
            guard let title = memo.memoTitle  else{
                return
            }
            guard let c = memo.memoContent  else{
                return
            }
            
            var contents = Array<String>()
            (c as! [String]).forEach{
                contents.append($0)
            }
            
            let m = Memo(title: title, content: contents)
            _memos.append(m)
        }
        
        return VStack{
            if(_memos.count > 0){
                MemoList(memos: _memos).environmentObject(apiModel)
            }else{
                EmptyView()
            }
        }
        .onAppear(){
            // 表示したら読み込み開始
            self.apiModel.load(viewContext: viewContext)
        };
    }
}


struct  MemoList:View {
    var memos : Array<Memo>
    @EnvironmentObject var apiModel :ApiModel
    
    /// 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) private var viewContext
    
    
    init(memos : Array<Memo>) {
        self.memos = memos
    }
    
    
    var body: some View{
        var swipe : SwipeRefreshController?
        
        swipe = SwipeRefreshController(coordinateSpaceName:"parent"){
            self.apiModel.load(viewContext: viewContext)
        }
        
        return NavigationView{
            ScrollView(.vertical){
                VStack{
                    swipe
                    
                    ForEach(self.memos, id: \.self){ memo in
                        // memoをタッチで詳細に飛べるようにする
                        NavigationLink(
                            destination: MemoDetailView(memo:memo)){
                            CardView(title: memo.title, contents: memo.content)
                        }
                    }
                }
            }
            .coordinateSpace(name: "parent")
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

