//
//  ContentView.swift
//  IosPractice
//
//  Created by kkkkan on 2021/05/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: Model
    var body: some View {
        NavigationView{
            VStack{
                Text("Hello, world!")
                    .font(.bold(.title)())
                    .padding()
                    .onTapGesture(perform: {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/ self.model.secondViewPushed = true
                    })
                Image("pyoko_kagamimochi")
                    .resizable()
                    .frame(
                        width: 380,
                        height: 400,
                        alignment: .top)
                    .cornerRadius(20)
                // 遷移する先と条件を指定するためのView。何も見えるものは設定していないので見えない
                NavigationLink(destination: CardView(title : "title",contents: ["a","i","u"]), isActive: self.$model.secondViewPushed){
                    //                    Button(action: {
                    //                        //self.model.secondViewPushed = true
                    //                    }) {
                    //                    EmptyView()
                    //                                            Image("pyoko_kagamimochi")
                    //                                                .resizable()
                    //                                                .frame(
                    //                                                    width: 380,
                    //                                                    height: 400,
                    //                                                    alignment: .top)
                    //                                                .cornerRadius(20)
                    //                    .disabled(false)
                    //Text("次へ")
                }
                //                }
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
