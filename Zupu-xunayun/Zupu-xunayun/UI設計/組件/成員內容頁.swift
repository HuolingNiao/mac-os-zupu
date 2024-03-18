//
//  成員內容頁.swift
//  S軒轅族譜
//
//  Created by 火靈 鳥 on 2024/1/3.
//

import Foundation
import SwiftUI

struct 成員頁面: View {
    @ObservedObject var 用戶數據: 共用數據
    //@EnvironmentObject private var 用戶數據: 共用數據
    //@Binding private var a:[String]
    @State var b:[[String]]
    @State var 頁碼 = [0,1]
    let 尺寸 = 通用紙張["A3"]
    @State private var 當前頁 = 0
    @State var 縮放比例:CGFloat = 1
    var body: some View {
        VStack {
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
                        //Spacer().frame(width: 50)
                        成員文本視圖(家庭: b[a*2+1])
                            .frame(width: 480,alignment: .bottomTrailing)
                            
                        Spacer().frame(width: 130)
                        成員文本視圖(家庭: b[a*2])
                            .frame(width: 480,alignment: .bottomTrailing)
                            
                    }.frame(height:720,alignment: .top)
                    
                }.scaleEffect(縮放比例)
            }
            
            
            
        }
    }
    
}
