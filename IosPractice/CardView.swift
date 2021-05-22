//
//  CardView.swift
//  IosPractice
//
//  Created by kkkkan on 2021/05/22.
//
import SwiftUI


// カードView。コンテンツの数は自由。
struct CardView: View {
    let title :String
    let contents : Array<String>
    
    init(title:String,contents:Array<String>) { // コンストラクター
        self.title = title
        self.contents=contents
    }
    
    
    var body: some View {
        ZStack{
            // FrameLayout的なやつ
            
            // 背景として赤色（red）を指定
            // 背景の付け方はこれで正しいのかは不明
            Color.red
                .frame(width:380, height: 400)
                .cornerRadius(20)
            VStack{
                // 縦に積んでいく親View　縦型LinearLayout
                Text(self.title)
                    .font(.bold(.title)())
                    .padding()
                    .onTapGesture(perform: {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                    })
                //            List{ // 最初はListを使っていたが、そうすると引っ張ると下に伸びるアニメーションがかかるのでただVStackに足していくだけにした。
                ForEach(contents,id: \.self){ c in
                    Text(c)
                    //.font(.bold(.title)())
                    //.padding()
                    //                }
                }
            }.frame(
                width: 380,
                height: 400,
                alignment: .top)
            //.border(Color.black)
            .cornerRadius(20)
            
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title:"タイトル", contents :["あ","い"])
    }
}

