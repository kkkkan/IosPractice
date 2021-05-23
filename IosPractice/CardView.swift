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
            VStack{
                // 縦に積んでいく親View　縦型LinearLayout
                Text(self.title)
                    .font(.bold(.title)())
                    .padding()
                    .frame(maxWidth: .infinity,alignment : Alignment.leading)
                    .onTapGesture(perform: {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                    })
                //最初はListを使っていたが、そうすると引っ張ると下に伸びるアニメーションがかかるのでただVStackに足していくだけにした。
                ForEach(contents,id: \.self){ c in
                    Text(c)
                        .padding().frame(maxWidth: .infinity,alignment : Alignment.leading)
                }
            }
            .frame(
                maxWidth: .infinity, // 横幅match_parent
                alignment: .top)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2)
            )
            .cornerRadius(20)
            .padding() // frameより後にpaddingをつけると、marginになる
            
            
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title:"タイトル", contents :["あ","い"])
    }
}

