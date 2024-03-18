//
//  欢迎界面.swift
//  Zupu-xunayun
//
//  Created by 火靈 鳥 on 2024/1/19.
//

import Foundation
import SwiftUI

struct 欢迎界面:View{
    @EnvironmentObject private var 用戶數據: 共用數據
    @State var 菜單 = false
    var body: some View {
            HStack{
                ZStack {
                    Image("bg1")
                        .resizable()
                        .scaledToFit()
                    Text("轩辕族谱")
                        .modifier(中文風格(字號: 60, 字體: .康熙))
                        .foregroundColor(.black)
                NavigationStack {
                    NavigationLink{
                        分支圖頁面(用戶數據: 用戶數據)
                        }label: {
                            Text("新建族譜")
                            .font(.custom("TpldKhangXiDict", size: 24))
                            .foregroundColor(.black)
                    }.offset(x:50,y:190)
                    NavigationLink{
                        读取界面(用戶數據: 用戶數據, 菜單: $菜單)
                        }label: {
                            Text("继续编辑")
                            .font(.custom("TpldKhangXiDict", size: 24))
                            .foregroundColor(.black)
                    }.offset(x:50,y:190)
                    NavigationLink{
                        編輯頁面()
                        }label: {
                            Text("预览族谱")
                            .font(.custom("TpldKhangXiDict", size: 24))
                            .foregroundColor(.black)
                    }.offset(x:50,y:190)
                }
            }
            
        }
    }
}
