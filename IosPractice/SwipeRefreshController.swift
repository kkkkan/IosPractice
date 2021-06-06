//
//  SwipeRefreshController.swift
//  IosPractice
//
//  Created by kkkkan on 2021/05/29.
//

import SwiftUI

class RefreshManager : ObservableObject {
    @Published var isRefreshing = false
}

// スワイプしたら更新中のクルクルをだしてリフレッシュコールバックを呼ぶためのView
struct SwipeRefreshController: View {
    init(coordinateSpaceName : String,onRefresh : @escaping (()->Void)) {
        // クロージャがスコープ外でも生きる時は@escapeが必要　https://qiita.com/mishimay/items/1232dbfe8208e77ed10e#%E3%81%A9%E3%81%86%E3%81%84%E3%81%86%E3%81%A8%E3%81%8D%E3%81%AB%E5%BF%85%E8%A6%81%E3%81%8B
        self.coordinateSpaceName = coordinateSpaceName
        self.onRefresh = onRefresh
        //isRefreshing = false
    }
    
    @ObservedObject var refreshManager = RefreshManager() // @Stateでただのbool値にしていると、外からfalseにしても反映されなかったので、ObservaleObjectクラスを作ってその中のプロパティにする。
    
    // クルクルを消す
    public func finishRefresh(){
        print("finishRefresh")
        self.refreshManager.isRefreshing = false
    }
    var coordinateSpaceName: String
    var onRefresh: () -> Void // スワイプをした時のコールバック
    
    
    var body: some View {
        return GeometryReader { geometry in
            VStack{
                if geometry.frame(in: .named(coordinateSpaceName)).midY > 100 {
                    Spacer()
                        .onAppear() {
                            //isRefreshing = true
                            self.refreshManager.isRefreshing = true
                            onRefresh()
                        }
                }
                if (self.refreshManager.isRefreshing) {
                    HStack {
                        Spacer()
                        
                        ProgressView()
                        
                        Spacer()
                    }
                }
            }
        }//.padding(.top, -40)
    }
}
