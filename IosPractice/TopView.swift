//
//  TopView.swift
//  IosPractice
//
//  Created by kkkkan on 2021/05/23.
//

import SwiftUI


struct TopView: View {
    @EnvironmentObject var model :Model
    //    @State var isDataLoaded = false
    var memos : Array<Memo> = []
    
    
    var body: some View {
        
        //        NavigationView{
        VStack{
            //                NavigationLink(
            //                    destination: MemoList(memos: self.model.memos),
            //                    isActive: self.$model.isDataLoaded,
            //                    label: {
            //                        EmptyView()
            //                    })
            
            if(self.model.isDataLoaded){
                MemoList(memos: self.model.memos)
            }
        }
        /*}*/.onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                // 一秒後の遅延処理
                let contetn1=["a","b","c"]
                let content2=["1","2","3"]
                self.model.setMemos(memos:[Memo(title:"タイトル1",contents: contetn1),Memo(title:"タイトル2",contents: content2)] )
                //                self.memos = [Memo(title:"タイトル1",contents: contetn1),Memo(title:"タイトル2",contents: content2)]
                //                isDataLoaded = true
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
                    CardView(title: memo.title, contents: memo.contents)
                }
            }
        }
    }
}

struct Memo : Hashable {
    var title : String
    var contents : Array<String>
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
