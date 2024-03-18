//
//  书牌.swift
//  S軒轅族譜
//
//  Created by 火靈 鳥 on 2024/1/1.
//

import SwiftUI

struct 書牌: View {
    let 標題:String = "溫氏族譜"
    let 尺寸 = 通用紙張["A3"]
    @State var 縮放比例:CGFloat = 1
    var body: some View {
       
            ZStack{
                Image("空白雙面")
                    .resizable()
                    .frame(width: 尺寸!.寬*3, height: 尺寸!.高*3)
                // Text(用戶數據.封面標題+"氏族譜")
                Text(標題)
                    .modifier(中文風格(字號: 55, 字體: .康熙))
                    .foregroundColor(.black)
                    .offset(y: -180)
                
                HStack(alignment: .top){
                    Spacer().frame(width: 610)
                        .background(Color.red)
                    HStack(alignment: .center){
                        Text(農曆("2023.12.25").農曆文本())
                            .modifier(中文風格(字號: 35, 字體: .康熙))
                            .frame(height:700,alignment: .bottom)
                        Text(標題)
                            .modifier(中文風格(字號: 100, 字體: .康熙))
                            .padding(73)
                            
                            .frame(height:730,alignment: .center)
                            .background(Rectangle().stroke(lineWidth: 3))
                            .padding(35)
                        Text("富順縣飛龍觀迴龍灣")
                            .modifier(中文風格(字號: 45, 字體: .康熙))
                            .frame(width: 45,height: 720,alignment: .top)
                    }.frame(width: 485,height: 700)
                    
                    
                }.foregroundStyle(Color.black)
            }.scaleEffect(縮放比例)
    }
} 
