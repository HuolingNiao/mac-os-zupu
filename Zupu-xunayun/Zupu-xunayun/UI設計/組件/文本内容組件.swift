//
//  文本内容.swift
//  S軒轅族譜
//
//  Created by 火靈 鳥 on 2024/1/1.
//

import Foundation
import SwiftUI

struct 文本視圖: View {
    @State var 文本:[String]
    @State var 高度:CGFloat = 700
    @State var 字號:CGFloat
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            ForEach(文本, id: \.self) { 段落 in
                Text(段落)
                    .modifier(中文風格(字號:字號,字體:.康熙))
                    .foregroundColor(.black)
                    .frame(height: 高度,alignment: .top)
            }
        }
        .padding()
        .environment(\.layoutDirection, .rightToLeft)
    }
    init(_ 內容:String,高度:CGFloat = 1200,字號:CGFloat = 35){
        self.文本 = 文本處理(高度:高度).分段(text: 內容)
        self.高度 = 高度
        self.字號 = 字號
    }
    init(文本:[String],字號:CGFloat = 35){
        if !文本.isEmpty {
            self.文本 = 文本
           
        } else {
            self.文本 = []
        }
        self.字號 = 字號
    }
}
struct 文本處理 {
    var 寬度:CGFloat = 350
    var 高度:CGFloat = 700
    var 字號:CGFloat = 35
    private var 每行字數:Int{get{return(Int(高度/字號))}}
    private var 每頁行數:Int{get{return(Int(寬度/字號))}}
    func 分段(text: String) -> [String] {
        var c:[String] = []
        let a = text.components(separatedBy: "\n")
        for b in a {
            c += 分行(段落: b)
        }
        return c
    }
    
    private func 分行(段落: String) -> [String] {
        let text = 段落
        let chunkSize = 每行字數
        
        var chunks: [String] = []
        var startIndex = text.startIndex
        
        while startIndex < text.endIndex {
            let endIndex = text.index(startIndex, offsetBy: chunkSize, limitedBy: text.endIndex) ?? text.endIndex
            let chunk = text[startIndex..<endIndex]
            chunks.append(String(chunk))
            startIndex = endIndex
        }
        
        return chunks
    }
    func 分頁 (_ 內容:[String]) -> [[String]]{
        var 頁面內容:[[String]]=內容.拆分(by: 每頁行數)
        
        if 頁面內容.count % 2 != 0 {
            頁面內容.append([""])
            }
        
        return 頁面內容
    }
}
