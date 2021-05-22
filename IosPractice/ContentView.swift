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
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                    })
                
                NavigationLink(destination: SecondView(), isActive: self.$model.secondViewPushed){
                    Button(action: {
                        self.model.secondViewPushed = true
                    }) {
                        Image("pyoko_kagamimochi")
                            .resizable()
                            .frame(
                                width: 380,
                                height: 400,
                                alignment: .top)
                            .cornerRadius(20)
                        //.disabled(true)
                        //Text("次へ")
                    }
                }
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
