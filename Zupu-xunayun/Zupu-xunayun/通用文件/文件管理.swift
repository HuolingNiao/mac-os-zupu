//
//  文件管理.swift
//  Famliy
//
//  Created by 火靈 鳥 on 2023/12/14.
//


import Foundation

class 文件管理 {
    private let 文件管理器 = Foundation.FileManager.default
    private let 緩存文件夾名 = "緩存"
    private let 緩存文件名 = "緩存.json"
    
    func 保存(_ 數據: Data) {
        if !文件管理器.fileExists(atPath: 緩存文件夾名) {
            do {
                try 文件管理器.createDirectory(atPath: 緩存文件夾名, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("無法創建文件夾: \(error)")
                return
            }
        }
        
        let 路徑 = 緩存文件夾名 + "/" + 緩存文件名
        文件管理器.createFile(atPath: 路徑, contents: 數據, attributes: nil)
        
        print("文件保存成功: \(路徑)")
    }
    
    func 另存為(數據: Data, 文件夾: String, 文件名: String) {
        if !文件管理器.fileExists(atPath: 文件夾) {
                do {
                    // 创建文件夹
                    try 文件管理器.createDirectory(atPath: 文件夾, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("无法创建文件夹: \(error)")
                    return
                }
            }
        let 路徑 = 文件夾 + "/" + 文件名
        文件管理器.createFile(atPath: 路徑, contents: 數據, attributes: nil)
        
        print("文件保存成功: \(路徑)")
    }
    
    func 刪除(atPath 路徑: String) {
        do {
            try 文件管理器.removeItem(atPath: 路徑)
            
            print("刪除成功: \(路徑)")
        } catch {
            print("刪除失敗: \(error)")
        }
    }
    func 讀取文件(文件夾: String, 文件名: String) -> Data? {
        let 路徑 = 文件夾 + "/" + 文件名
        
        if 文件管理器.fileExists(atPath: 路徑) {
            
            return 文件管理器.contents(atPath: 路徑)
            
        } else {
            print("文件不存在: \(路徑)")
            return nil
        }
    }
}
