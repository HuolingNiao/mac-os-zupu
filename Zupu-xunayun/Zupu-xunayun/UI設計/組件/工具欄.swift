//
//  Tool.swift
//  軒轅族譜
//
//  Created by 火靈 鳥 on 2023/12/16.
//

import SwiftUI


    struct 人員工具欄: View {
        @EnvironmentObject private var 用戶數據: 共用數據
        @State var 菜單 = false
        var body: some View {
            HStack {
                Button(action: {
                    // 保存功能
                    用戶數據.保存()
                }) {
                    HStack{
                        Text("保存族譜")
                        Image(systemName: "square.and.arrow.down")}
                }
                Button(action: {
                    菜單.toggle()
                    // 保存功能
                    //用戶數據.讀取()
                    //用戶數據.更新成員文本()
                }) {
                    HStack{
                        Text("讀取族譜")
                        Image(systemName: "square.and.arrow.down.fill")}
                }
                Button(action: {
                    用戶數據.成員庫 = 成員數據(姓名: "始祖")
                    用戶數據.更新成員文本()
                    // 刪除功能
                }) {
                    HStack{
                        Text("新建族譜")
                        Image(systemName: "doc")}
                }
                
                Button(action: {
                    //用戶數據.pdf(內容: 文本頁面(用戶數據.封面標題))
                    // 導出功能
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            .padding()
            .sheet(isPresented: $菜單){
                读取界面(用戶數據: 用戶數據, 菜單: $菜單)
            }
        }
}
struct 族譜工具欄: View {
    @EnvironmentObject private var 用戶數據: 共用數據

    var body: some View {
        HStack {
            Button(action: {
                // 添加頁面功能
            }) {
                Image(systemName: "plus")
            }
            
            Button(action: {
                // 刪除頁面功能
            }) {
                Image(systemName: "minus")
            }
            
            //Spacer()
            
            Button(action: {
                //if 用戶數據.縮放 <= 2{ 用戶數據.縮放 += 0.2}
            }) {
                Image(systemName: "plus.magnifyingglass")
            }
            
            Button(action: {
                //if 用戶數據.縮放 >= 0.5{ 用戶數據.縮放 -= 0.2}// 縮小頁面功能
            }) {
                Image(systemName: "minus.magnifyingglass")
            }
            
            //Spacer()
            
            Button(action: {
                // 設置功能
            }) {
                Image(systemName: "gearshape")
            }
        }
        .padding()
    }
}

