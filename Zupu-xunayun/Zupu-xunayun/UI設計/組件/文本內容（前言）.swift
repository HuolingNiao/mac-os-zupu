//
//  neirong.swift
//  軒轅族譜
//
//  Created by 火靈 鳥 on 2023/12/16.
//

import SwiftUI

struct 文本頁面: View {
    
    @State var b:[[String]]
    @State var 內容:String
    let 尺寸 = 通用紙張["A3"]
    @State var 縮放比例:CGFloat = 1
    
    var body: some View {
        //ScrollView {
        VStack{
            ForEach(0..<b.count/2){a in
                ZStack{
                    Image("空白雙面")
                        .resizable()
                        .frame(width: 尺寸!.寬*3, height: 尺寸!.高*3)
                    // Text(用戶數據.封面標題+"氏族譜")
                    Text("溫氏族譜")
                        .modifier(中文風格(字號: 55, 字體: .康熙))
                        .foregroundColor(.black)
                        .offset(y: -180)
                    
                    HStack(alignment: .top){
                        //文本視圖(文本:左頁)
                        文本視圖(文本:b[a*2+1])
                            .frame(width: 480,alignment: .bottomTrailing)
                        
                        Spacer().frame(width: 140)
                        //文本視圖(文本:右頁)
                        文本視圖(文本:b[a*2])
                            .frame(width: 480,alignment: .bottomTrailing)
                        
                    }
                    .frame(alignment: .bottomLeading)
                }.scaleEffect(縮放比例)
            }
            
        }
                            
       // }
        
        
    }
    init(_ 文本:String?){
        self.內容 = 文本 ?? ""
        self.b = 文本處理().分頁(文本處理().分段(text: 文本 ?? ""))
        
    }
    init(){
        let a = 書籍().前言
        self.內容 = ""
        var d:[[String]] = []
        for c in a {
            d += 文本處理().分頁(文本處理().分段(text: c))
        }
        self.b=d
    }
    
}

