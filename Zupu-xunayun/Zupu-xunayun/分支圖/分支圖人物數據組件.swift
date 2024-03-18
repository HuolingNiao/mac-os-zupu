//
//  分支圖人物數據組件.swift
//  S軒轅族譜
//
//  Created by 火靈 鳥 on 2024/1/4.
//

import Foundation
struct 成員數據: Identifiable,Codable {
    var id = UUID()
    var 姓名: String
    var 世代: Int
    var 父親 = ""
    var 配偶: [成員數據]
    var 子女: [成員數據]
    var 簡介 = ""
    
    init(姓名: String, 配偶: [成員數據] = [], 子女: [成員數據] = []) {
        self.姓名 = 姓名
        self.子女 = 子女
        self.配偶 = 配偶
        self.世代 = 6
    }
    
    init(姓名: String, 世代: Int) {
        self.姓名 = 姓名
        self.子女 = []
        self.配偶 = []
        self.世代 = 世代
    }
}
extension 成員數據 {
    mutating func 添加配偶(_ 姓名: String){
        var a = 成員數據(姓名: 姓名, 世代: 世代)
        a.父親 = "\(self.姓名)之妻"
        self.配偶.append(a)
        
    }
    
    mutating func 添加子女(_ 姓名: String){
        let i = 世代 + 1
        var a = 成員數據(姓名: 姓名, 世代: i)
        a.父親 = self.姓名
        self.子女.append(a)
       
    }
    
    mutating func 刪除配偶(_ id: UUID) {
        self.配偶.removeAll { $0.id == id }
    }
    
    mutating func 刪除子女(_ id: UUID) {
        self.子女.removeAll { $0.id == id }
    }
    
    func 查找(by uuid: UUID) -> 成員數據? {
        if id == uuid {
            return self
        }
        
        for child in 子女 {
            if let result = child.查找(by: uuid) {
                return result
            }
        }
        
        return nil
    }
}
extension 成員數據 {
    mutating func 更新(_ 更新數據: 成員數據){
        if self.id == 更新數據.id {self = 更新數據} else {
            for _ in 配偶 {
                更新(更新數據)
            }
            for _ in 子女 {
                更新(更新數據)
            }
        }
        
    }
    mutating private func 更新配偶(_ 更新配偶: 成員數據) {
            if let index = 配偶.firstIndex(where: { $0.id == 更新配偶.id }) {
                配偶[index] = 更新配偶
            }
        }
        
        mutating private func 更新子女(_ 更新子女: 成員數據) {
            if let index = 子女.firstIndex(where: { $0.id == 更新子女.id }) {
                子女[index] = 更新子女
            }
        }
    
    func 成員文本() -> [String] {
        var 简介数组: [String] = []
        for a in self.輸出人員數組(){
            简介数组.append(a.簡介)
        }
                return (简介数组)
            
        }
    mutating func 生成簡介(出生時間:String,死亡時間:String,健在:Bool,女性:Bool) {
        func 文本() -> String {
            if 簡介 != "" {
                return("\(姓名)\n第\(世代.中文數字)世\n\(生歿時間())\n\(簡介)")
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
        func 計算年齡() -> String {
            if 死亡時間 != "" {
                return (農曆(出生時間).年數差(農曆(死亡時間)) ?? "出錯了")
            }
            return (農曆(出生時間).年數差(農曆()) ?? "出錯了")
        }
        簡介 = 文本()
    }
    
}

extension 成員數據 {
    func 保存(){
        let 文件管理器 = 文件管理()
        let 編碼器 = JSONEncoder()
        編碼器.outputFormatting = .prettyPrinted
        
        do {
            let 庫 = try 編碼器.encode(self)
            文件管理器.另存為(數據: 庫, 文件夾: "族譜緩存", 文件名: "成員庫")
        } catch {
            print("儲存失敗：\(error)")
        }
    }
    func 讀取() -> 成員數據?{
        let 解碼器 = JSONDecoder()
        let 庫數據 = 文件管理().讀取文件(文件夾: "族譜緩存", 文件名: "成員庫")
        do {
            if let 庫數據 = 庫數據 {
                let 成員庫 = try 解碼器.decode(成員數據.self, from: 庫數據)
                return 成員庫
                   }
        } catch {
            print("讀取失敗：\(error)")
        }
        return nil
    }
}
extension 成員數據 {
    func 拆分为五代数组() -> [[成員數據]] {
        var 拆分结果: [[成員數據]] = []
        var 当前数组: [成員數據] = []
        var 根元素: 成員數據? = nil
        
        // 找到根元素
        var 当前成員: 成員數據? = self
        while let 父親成員 = 当前成員 {
            根元素 = 父親成員
            当前成員 = 父親成員.子女.last
        }
        
        // 递归拆分
        func 递归拆分(成員: 成員數據) {
            当前数组.append(成員)
            
            if 成員.世代 % 5 == 0 {
                拆分结果.append(当前数组)
                当前数组 = []
            }
            
            for 子女成員 in 成員.子女 {
                递归拆分(成員: 子女成員)
            }
        }
        
        if let 根元素 = 根元素 {
            递归拆分(成員: 根元素)
        }
        
        if !当前数组.isEmpty {
            拆分结果.append(当前数组)
        }
        
        return 拆分结果
    }
    private func 輸出人員數組() -> [人員ss] {
        var 人員2: [人員ss] = []
        //var 配偶数组: [String] = []
                // 提取当前成员的简介
        if !self.簡介.isEmpty {
            人員2.append(人員ss(簡介:簡介,世代:世代))
        }
        if !self.配偶.isEmpty {
            for a in 配偶 {
                人員2.append(人員ss(簡介:a.簡介,世代:世代))}
        }
        for a in 子女 {
            人員2 += a.輸出人員數組()
        }
        人員2.sort { (简介1, 简介2) -> Bool in
            return 简介1.世代 < 简介2.世代
                }
        return 人員2
    }
}

struct 人員ss {
    var 簡介:String
    var 世代:Int
    init(簡介: String, 世代: Int) {
        self.簡介 = 簡介
        self.世代 = 世代
    }
}
