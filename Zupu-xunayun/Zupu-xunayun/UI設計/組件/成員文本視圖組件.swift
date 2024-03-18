//
//  成員文本視圖.swift
//  S軒轅族譜
//
//  Created by 火靈 鳥 on 2024/1/2.
//

import SwiftUI
struct 成員文本基本數據 {
    var 姓名:String
    var 世代:String
    var 關係:String
    var 簡介:String
    init(姓名: String, 世代: String, 關係: String, 簡介: String) {
        self.姓名 = 姓名
        self.世代 = 世代
        self.關係 = 關係
        self.簡介 = 簡介
    }
    init (_ 內容:String) {
        let components = 內容.components(separatedBy: "\n")
                if components.count >= 4 {
                    self.關係 = components[0]
                    self.姓名 = components[1]
                    self.世代 = components[2]
                    self.簡介 = components[3]
                } else {
                    self.關係 = ""
                    self.姓名 = ""
                    self.世代 = ""
                    self.簡介 = ""
                }
            }
        
}

struct 單個成員視圖: View {
    var 單個成員信息: 成員文本基本數據

    var body: some View {
        VStack() {
            HStack{
                
                VStack{
                    Text(單個成員信息.世代)
                        .modifier(中文風格(字號:14,字體:.康熙))
                    Spacer().frame(height:20)
                    Text(單個成員信息.關係)
                        .modifier(中文風格(字號:14,字體:.康熙))
                }
                Text(單個成員信息.姓名)
                    .modifier(中文風格(字號:35,字體:.康熙))
                
            }
            
                .frame(height: 170)

            文本視圖(單個成員信息.簡介,字號:15)
        }
    }
}
struct 成員文本視圖: View {
    var 家庭: [String]
    var body: some View {
        HStack(alignment: .top,spacing: 7) {
                   ForEach(家庭, id: \.self) { a in
                       單個成員視圖(單個成員信息: 成員文本基本數據(a))
                   }
               }.environment(\.layoutDirection, .rightToLeft)
    }
}


