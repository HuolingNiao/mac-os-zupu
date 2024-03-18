//
//  成員數據定義.swift
//  Famliy
//
//  Created by 火靈 鳥 on 2023/12/14.
//

import Foundation
struct 人員: Codable,Identifiable {
    var id = UUID()
    var 姓名:String
    var 世代:Int
    var 健在: Bool = true
    var 性別: String = "男"
    var 配偶:[UUID] = []
    var 子女:[UUID] = []
    var 出生時間:String = ""
    var 死亡時間:String = ""
    var 生平簡介:String = ""
    init(_ 姓名:String){
        self.姓名 = 姓名
        self.世代 = 1
    }
    init(id:UUID,姓名:String,世代:Int){
        self.id = id
        self.姓名 = 姓名
        self.世代 = 世代
    }
    
    func 文本() -> String {
        if 生平簡介 != "" {
            return("\(姓名)\n第\(世代.中文數字)世\n\(生歿時間())\n\(生平簡介)")
        }
        return("\(姓名)\n第\(世代.中文數字)世\n\(生歿時間())")
        
    }
    func 生歿時間() -> String {
        if 出生時間 != "", 死亡時間 != "" {
            return "生於\(農曆(出生時間).農曆文本())，歿於\(農曆(死亡時間).農曆文本())，享年\(計算年齡())歲"
        } else if 出生時間 != "" {
            return "生於\(農曆(出生時間).農曆文本())，現年\(計算年齡())歲"
        } else if 死亡時間 != "" {
            return "出生歿時間不詳，歿於\(農曆(死亡時間).農曆文本())"
        } else {
            return "生歿時間不詳"
        }
    }
    private func 計算年齡() -> String {
        if 死亡時間 != "" {
            return (農曆(出生時間).年數差(農曆(死亡時間)) ?? "出錯了")
        }
        return (農曆(出生時間).年數差(農曆()) ?? "出錯了")
    }
}
