//
//  读取界面.swift
//  Zupu-xunayun
//
//  Created by 火靈 鳥 on 2024/1/19.
//

import Foundation
import SwiftUI

struct 读取界面: View {
    @ObservedObject var 用戶數據: 共用數據
    @Binding var 菜單:Bool
    private let fileManager = FileManager.default
    private let fileFolder = "族譜緩存" // 替换为您要读取的文件夹路径
    
    var body: some View {
        VStack {
            Text("文件列表")
                .font(.title)
                .padding()
            
            // 获取文件夹中的文件列表
            let files = getFiles()
            
            if files.isEmpty {
                Text("没有文件")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(files, id: \.self) { file in
                            Button(action: {
                                用戶數據.成員庫=readFile(file)!
                                用戶數據.更新成員文本()
                                菜單.toggle()
                            }) {
                                Text(file)
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    private func getFiles() -> [String] {
        guard let files = try? fileManager.contentsOfDirectory(atPath: fileFolder) else {
            print("无法读取文件夹")
            return []
        }
        
        return files
    }
    
    private func readFile(_ file: String)-> 成員數據? {
        let filePath = (fileFolder as NSString).appendingPathComponent(file)
        
        // 在这里执行读取文件的操作
        let 庫數據 = FileManager.default.contents(atPath: filePath)
        let 解碼器 = JSONDecoder()
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
