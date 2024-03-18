//
//  fengm.swift
//  Famliy
//
//  Created by 火靈 鳥 on 2023/12/16.
//

import SwiftUI

struct 封面: View {
    let 標題:String = "溫氏族譜"
    let 尺寸 = 通用紙張["A4"]
    @State var 縮放比例: CGFloat = 1
    
    var body: some View {
            VStack {
                ZStack {
                    Image("封面")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 尺寸!.寬*3 , height: 尺寸!.高*3)
                    
                    Text(標題)
                        .modifier(中文風格(字號: 60, 字體: .康熙))
                        .foregroundColor(.black)
                        .offset(x: -170 , y: -150 )
                }.scaleEffect(縮放比例)
            }
    }
}





