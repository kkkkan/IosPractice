//
//  ApiModel.swift
//  IosPractice
//
//  Created by kkkkan on 2021/05/23.
//

import SwiftUI
import Combine

class ApiModel: ObservableObject {
    @Published var memos : Array<OptionalObject<Memo>> = []
    @Published var isLoaded = false
    
    private let API_BASE =
        "https://script.google.com/macros/s/AKfycbyQiZJ0i3Ewkz7XdArZGHhpnVvEs27B6JORMV13uDf_0lIzpKFYw2QvVPPYqenzRWTQVA/exec"

    private let API_PATH_GET_ALL_DATA="?apiName=getAllData"
    
    init() {
        load()
    }
    
    private func load() {
            let url = URL(string: API_BASE+API_PATH_GET_ALL_DATA)!
            URLSession.shared.dataTask(with: url) { data, response, error in
                print("data: \(String(describing: data))")
                do{
                         let couponData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                         print(couponData) // Jsonの中身を表示
                     }
                     catch {
                         print(error)
                     }
//                        print("response: \(String(describing: response))")
//                        print("error: \(String(describing: error))")
                DispatchQueue.main.async {
//                    let shiftJisJsonString = String(data: data!, encoding: .shiftJIS)
//                    let utf8Json = shiftJisJsonString?.data(using: .utf8)
                    
                    self.memos = try! JSONDecoder().decode(Array<OptionalObject<Memo>>.self, from: data!)
                    self.isLoaded=true
                }
            }.resume()
        }
    
//    func setMemos(memos : Array<Memo>) -> () {
//        self.memos = memos
//        self.isDataLoaded=true
//    }
    
}


public struct OptionalObject<Base: Decodable>: Decodable {
    public let value: Base?

    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Base.self)
        } catch {
            self.value = nil
        }
    }
}
