//
//  ApiModel.swift
//  IosPractice
//
//  Created by kkkkan on 2021/05/23.
//

import SwiftUI
import Combine
import CoreData

class ApiModel: ObservableObject {
   
    
    @Published var memos : Array</*OptionalObject<*/Memo/*>*/> = []
   
    init() {
        
    }
    
    
    private let API_BASE =
        "https://script.google.com/macros/s/AKfycbzFXBeW8J-DYvaKBo5_8sX7QtI9OQQXIJKeZyqbrvFwqUJnDbYAbN74puI31gdqxUyx7A/exec"
    
    private let API_PATH_GET_ALL_DATA="?apiName=getAllData"

    
    public func load(memosContainer : Binding<Array<Memo>>? = nil) {
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
                if(memosContainer == nil){
                    self.memos = try! JSONDecoder().decode(Array<Memo>.self, from: data!)
                }else{
                    memosContainer!.wrappedValue =    try! JSONDecoder().decode(Array<Memo>.self, from: data!)
                }
            }
        }.resume()
    }
    
    
    public func load(viewContext : NSManagedObjectContext) {
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
//                if(memosContainer == nil){
                     let memos = try! JSONDecoder().decode(Array<Memo>.self, from: data!)
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
                    do {
                        try viewContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
//                }else{
//                    memosContainer!.wrappedValue =    try! JSONDecoder().decode(Array<Memo>.self, from: data!)
//                }
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
