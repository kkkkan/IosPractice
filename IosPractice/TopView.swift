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
//            if(self.apiModel.memos.count>0){
//                ForEach(items){ item in
//                    var memo = Memo(title: item.memoTitle, content: item.memoContent?)
//                }
//                var _memos = Array<Memo>()
//                ForEach(self.items,id : \.self){ memo in
//                    var contents = Array<String>()
//                    (memo.memoContent as [String]).forEach{
//                        contents.append($0)
//                    }
//
//                    let m = Memo(title: memo.memoTitle, content: contents)
//                    _memos.append(m)
//                }
                 MemoList(memos: _memos).environmentObject(apiModel)
            }else{
                EmptyView()
            }
        }
        .onAppear(){
//            let p = Binding<Array<Memo>>(get : {
//                return self.apiModel.memos
//            },set : { memos in
//    //            let newTask = Title(context: self.viewContext)
//    //            newTask.memoTitle = self.memos[0].title
//    //            do{
//    //                try self.viewContext.save()
//    //            }catch{
//    //
//    //            }
//    //                                   newTask.date = date
//    //                                   newTask.content = content
//                memos.forEach{ m in
//                    let newItem = Memos(context: viewContext)
//                    newItem.id=UUID()
//                    newItem.memoTitle = m.title
//                    var cs : [String]=[]
//                    m.content.forEach{ c in
//                        cs.append(c)
//                    }
//                    newItem.memoContent = cs as NSObject
//
//                }
//    //            for _ in 0..<10 {
//    //                let newItem = Memos(context: viewContext)
//    //                newItem.memoTitle = memo
//    //            }
//                do {
//                    try viewContext.save()
//                } catch {
//                    // Replace this implementation with code to handle the error appropriately.
//                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                    let nsError = error as NSError
//                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//                }
//                //self.apiModel.memos = memos
//
//            })
            
        
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
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Title.memoTitle, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Title>
 
    
    init(memos : Array<Memo>) {
        self.memos = memos
    }
    
    
    var body: some View{
        var swipe : SwipeRefreshController?
        
        // 中間橋渡しをしてくれるオブジェクトを作ることで、データが更新されたらクルクルを消せるようにする。
        let p = Binding<Array<Memo>>(get : {
            return self.apiModel.memos
        },set : { memos in
//            let newTask = Title(context: self.viewContext)
//            newTask.memoTitle = self.memos[0].title
//            do{
//                try self.viewContext.save()
//            }catch{
//                
//            }
//                                   newTask.date = date
//                                   newTask.content = content
            swipe?.finishRefresh() // データ取得が終わったのでクルクルを止める
            memos.forEach{ m in
                let newItem = Memos(context: viewContext)
                newItem.id=UUID()
                newItem.memoTitle = m.title
                var cs : [String]=[]
                m.content.forEach{ c in
                    cs.append(c)
                }
                newItem.memoContent = cs as NSObject
                
            }
//            for _ in 0..<10 {
//                let newItem = Memos(context: viewContext)
//                newItem.memoTitle = memo
//            }
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            //self.apiModel.memos = memos
            
        })
        
        swipe = SwipeRefreshController(coordinateSpaceName:"parent"){
//            self.apiModel.load(memosContainer: p)
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

