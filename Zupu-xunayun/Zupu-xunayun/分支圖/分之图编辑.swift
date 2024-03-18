//
//  分支圖頁面.swift
//  S軒轅族譜
//
//  Created by 火靈 鳥 on 2023/12/27.
//

import Foundation
import SwiftUI

struct 分支圖頁面: View {
     @ObservedObject var 用戶數據: 共用數據
    @State var 配偶顯示 = true
    let 尺寸 = 通用紙張["A3"]
    @State var 縮放比例:CGFloat = 0.9
    var body: some View {
        
        ZStack{
            Image("空白雙面1")
                .resizable()
                .frame(width: 尺寸!.寬*3, height: 尺寸!.高*3)
            /*Text("溫氏族譜")
             .modifier(中文風格(字號: 55, 字體: .康熙))
             .foregroundColor(.black)
             .offset(y: -180)*/
            VStack{
                人員工具欄()
                HStack(alignment: .top){
                    //成員輸入介面(數據:數據, 當前人員數據: $當前人員).frame(maxWidth:220)
                    Spacer()
                    分支視圖(分支數據: $用戶數據.成員庫).zIndex(1)
                    Spacer().frame(width: 50)
                    HStack{
                        Text("軒轅族譜")
                            .modifier(中文風格(字號: 35, 字體: .康熙))
                        //.foregroundColor(.black)
                        
                    }
                    //Button("隱藏配偶"){用戶數據.配偶顯示.toggle() }
                }
                .frame(width: 1100, height: 700, alignment: .top)
                .scaleEffect(縮放比例)
                //.background(Color.red)
                
            }//.scaleEffect(縮放比例)}
            
        }
    }
}
