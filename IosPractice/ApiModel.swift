//
//  ApiModel.swift
//  IosPractice
//
//  Created by kkkkan on 2021/05/23.
//

import SwiftUI
import Combine

class ApiModel: ObservableObject {
    @Published var memos : Array</*OptionalObject<*/Memo/*>*/> = []
    @Published var isLoaded = false
    
    private let API_BASE =
        "https://script.google.com/macros/s/AKfycbzFXBeW8J-DYvaKBo5_8sX7QtI9OQQXIJKeZyqbrvFwqUJnDbYAbN74puI31gdqxUyx7A/exec"
    
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
            DispatchQueue.main.async {
                self.memos = try! JSONDecoder().decode(Array<Memo>.self, from: data!)
                self.isLoaded=true
            }
        }.resume()
    }
    
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
