//
//  Zupu_xunayunApp.swift
//  Zupu-xunayun
//
//  Created by 火靈 鳥 on 2024/1/7.
//

import SwiftUI

@main
struct Zupu_xunayunApp: App {
    @StateObject private var 用戶數據 = 共用數據()
        var body: some Scene {
            WindowGroup {
                //成員輸入介面(數據庫2: $a)
                //文本編輯()
               // 分支圖(分支圖2)
               //文本頁面()
                //編輯頁面()
                欢迎界面()
                //分支圖頁面()
                .environmentObject(用戶數據)
            }
        }

}
