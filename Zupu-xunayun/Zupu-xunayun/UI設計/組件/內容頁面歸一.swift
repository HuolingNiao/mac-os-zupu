//
//  內容頁面歸一.swift
//  S軒轅族譜
//
//  Created by 火靈 鳥 on 2023/12/26.
//

import Foundation
import SwiftUI


enum 頁面類型:String {
    case 封面
    case 書牌
    case 前言
    case 內容
    case 分支圖
    case 字輩
}

struct 頁面: View {
    //@EnvironmentObject private var 用戶數據: 共用數據
    @ObservedObject var 用戶數據=共用數據()
    @Binding var 內容頁面: String
    var body: some View {
        VStack {
            if 內容頁面 == "前言"{
                文本頁面()
            } else {
                switch 內容頁面 {
                case "封面":
                    封面()
                case "書牌":
                    書牌()
                case "內容":
                    成員頁面(用戶數據: 用戶數據, b: 用戶數據.成員頁面文本)
                case "分支圖":
                    分支圖显示頁面(用戶數據: 用戶數據)
                case "字輩":
                    文本頁面(書籍().字輩頁面)
                default:
                    文本頁面(書籍().後記)
                }
            }
        }
    }
}

