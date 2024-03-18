//
//  文字風格.swift
//  Famliy
//
//  Created by 火靈 鳥 on 2023/12/16.
//

import Foundation
import SwiftUI
enum 中文字體:String{
    case 康熙="TpldKhangXiDict"
    case 浙江="ChekiangSung"
    case 篆書="winman-tun100119"
    case 楷書 = "KouzanBrushFont"
    case 行書 = "HanWangShinSuMedium"
}
struct 中文風格: ViewModifier {
    var 字號:CGFloat = 25
    var 字體 = 中文字體.篆書
    func body(content: Content) -> some View {
        content
            .frame(width: 字號)
            .font(.custom(字體.rawValue, size: 字號))
    }
}



