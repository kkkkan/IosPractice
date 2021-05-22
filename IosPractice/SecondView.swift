//
//  SecondView.swift
//  IosPractice
//
//  Created by kkkkan on 2021/05/22.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("遷移したよ")
                    .font(.bold(.title)())
                    .padding()
                    .onTapGesture(perform: {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                    })
                
                //        NavigationLink(destination: SecondView(), isActive: self.$model.secondViewPushed) {
                //                            Button(action: {
                //                                self.model.secondViewPushed = true
                //                            }) {
                //                                Text("次へ")
                //                            }
                //                        }
            }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}

