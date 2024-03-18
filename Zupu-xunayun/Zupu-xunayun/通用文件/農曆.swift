//
//  農曆.swift
//  Famliy
//
//  Created by 火靈 鳥 on 2023/12/14.
//

import Foundation
import SwiftUI
extension Int {
    static let 中文數字組 = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九"]
    
    var 中文數字: String {
        if self < 0 {
            return "负" + (-self).中文數字
        }
        
        if self < 10 {
            return Int.中文數字組[self]
        }
        
        var result = ""
        var num = self
        
        if num >= 10_000 { // 处理万以上的部分
            let yi = num / 10_000
            result += "\(yi.中文數字)萬"
            num %= 10_000
        }
        
        if num >= 1_000 {  // 处理千位以上的部分
            let qian = num / 1_000
            result += "\(qian.中文數字)千"
            num %= 1_000
        }
        
        if num >= 100 {  // 处理百位以上的部分
            let bai = num / 100
            result += "\(bai.中文數字)百"
            num %= 100
        }
        
        if num >= 10 {  // 处理十位以上的部分
            let shi = num / 10
            if shi > 1 {
                result += "\(Int.中文數字組[shi])十"
            } else {
                result += "十"
            }
            num %= 10
        }
        
        if num > 0 {  // 处理个位数字
            result += Int.中文數字組[num]
        }
        
        return result
    }
    var 中文字: String {
            var a = ""
        let b = String(self)
        for c in b {
            if let e = Int(String(c)){
                let z = Int.中文數字組[e]
                a.append(z)
            }
        }
        return a
        }
}
struct 農曆 {
    public var 年:Int?
    public var 月:Int?
    public var 日:Int?
    public var 時:Int?
    let 六十甲子 = ["甲子", "乙丑", "丙寅", "丁卯", "戊辰", "己巳", "庚午", "辛未", "壬申", "癸酉", "甲戌", "乙亥", "丙子", "丁丑", "戊寅", "己卯", "庚辰", "辛巳", "壬午", "癸未", "甲申", "乙酉", "丙戌", "丁亥", "戊子", "己丑", "庚寅", "辛卯", "壬辰", "癸巳", "甲午", "乙未", "丙申", "丁酉", "戊戌", "己亥", "庚子", "辛丑", "壬寅", "癸卯", "甲辰", "乙巳", "丙午", "丁未", "戊申", "己酉", "庚戌", "辛亥", "壬子", "癸丑", "甲寅", "乙卯", "丙辰", "丁巳", "戊午", "己未", "庚申", "辛酉", "壬戌", "癸亥"]
    let 月份 = ["正月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "冬月", "臘月"]
    let 日子 = ["初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "廿", "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "卅","卅一"]
    let 時辰 = ["子時", "丑時", "寅時", "卯時", "辰時", "巳時", "午時", "未時", "申時", "酉時", "戌時", "亥時"]
    init(年:Int,月:Int,日:Int,時:Int?){
        self.年 = 年
        self.月 = 月
        self.日 = 日
        self.時 = 時
    }
    init(_ 日期: String = "") {
        if !日期.isEmpty {
            let 日期2 = 轉換日期格式(日期文本: 日期)
            guard 日期2 != nil else { return }
            guard 格式檢查(日期2!) else { return }
            let 日期內容 = 日期2!.components(separatedBy: "-")
            self.年 = Int(日期內容[0])
            self.月 = Int(日期內容[1])
            self.日 = Int(日期內容[2])
        } else {
            let currentCalendar = Calendar.current
            let components = currentCalendar.dateComponents([.year, .month, .day], from: Date())
            self.年 = components.year
            self.月 = components.month
            self.日 = components.day
        }
    }
    func 農曆文本()->String{
        if 年 != nil {
            var n = ""
            var y = ""
            var r = ""
            var s = ""
            let a = (年! - 1864) % 60
            n = 六十甲子[a]
            y = 月份[月!-1]
            r = 日子[日!-1]
            if 時 != nil {s = 時辰[時!-1]}
            let si = 年!.中文字
            return(si+n+"年"+y+r+s)
        } else {
            return "不詳"
        }
    }
    func 年數差(_ otherDate: 農曆) -> String?{
        guard let 年1 = self.年, let 月1 = self.月, let 日1 = self.日,
              let 年2 = otherDate.年, let 月2 = otherDate.月, let 日2 = otherDate.日 else {
            return nil
        }
        
        var 年數差值 = 年2 - 年1
        var 月補正 = 月2 - 月1
        var 日補正 = 日2 - 日1
        if 月補正 < 0{月補正 = 1} else {月補正 = 0}
        if 日補正 < 0{日補正 = 1} else {日補正 = 0}
        if 月補正 == 0 {
            年數差值 -= 日補正
        } else {年數差值 -= 月補正}
        
        return (年數差值.中文數字)
    }
    func 當前時間() -> 農曆{
        var 日期格式: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }
        return(農曆(日期格式.string(from: Date())))
    }
    public func 格式檢查(_ 輸入:String) -> Bool {
        let 格式 = #"^\d{4}-\d{2}-\d{2}"#
        let a = try! NSRegularExpression(pattern: 格式)
        let b = NSRange(location: 0, length: 輸入.utf16.count)
        return a.firstMatch(in: 輸入, options: [], range: b) != nil
    }
    public func 轉換日期格式(日期文本: String) -> String? {
        let 日期格式 = DateFormatter()
        日期格式.locale = Locale(identifier: "en_US_POSIX") // 使用英语区域设置
        
        // 尝试解析 "yyyy年MM月dd日" 格式的日期
        日期格式.dateFormat = "yyyy年MM月dd日"
        if let 日期 = 日期格式.date(from: 日期文本) {
            日期格式.dateFormat = "yyyy-MM-dd" // 指定输出日期字符串的格式
            return 日期格式.string(from: 日期)
        }
        
        // 尝试解析 "yyyy-MM-dd" 格式的日期
        日期格式.dateFormat = "yyyy-MM-dd"
        if let 日期 = 日期格式.date(from: 日期文本) {
            日期格式.dateFormat = "yyyy-MM-dd" // 指定输出日期字符串的格式
            return 日期格式.string(from: 日期)
        }
        
        // 尝试解析 "yyyy.M.d" 格式的日期
        日期格式.dateFormat = "yyyy.MM.dd"
        if let 日期 = 日期格式.date(from: 日期文本) {
            日期格式.dateFormat = "yyyy-MM-dd" // 指定输出日期字符串的格式
            return 日期格式.string(from: 日期)
        }
        
        return nil // 日期转换失败
    }

}
