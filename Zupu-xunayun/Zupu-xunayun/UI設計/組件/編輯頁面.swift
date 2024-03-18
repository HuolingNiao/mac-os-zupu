//
//  man.swift
//  軒轅族譜
//
//  Created by 火靈 鳥 on 2023/12/16.
//

import SwiftUI

struct 編輯頁面: View {
    @State var pages = ["封面", "書牌", "前言", "目錄", "字輩","分支圖","內容", "封底"] // 書籍頁面數據
    @State var selectedPage: String?
    @State var 顯示頁面 = "封面"

    var body: some View {
        NavigationSplitView {
            VStack{
                List {
                    ForEach(pages, id: \.self) { page in
                        Text(page)
                            .onTapGesture {
                                selectedPage = page
                                顯示頁面 = page
                        }
                    }
                }
                .contextMenu(menuItems: {
                                Button(action: {
                                    if let selectedPage = selectedPage {
                                        let 頁碼 = pages.count - 1
                                        insertPage(after: selectedPage, page2: "內容\(頁碼)")
                                    }
                                }) {
                                    Label("添加頁面", systemImage: "plus")
                                }
                                
                                Button(action: {
                                    if let selectedPage = selectedPage, let index = pages.firstIndex(of: selectedPage) {
                                        removePage(at: index)
                                    }
                                }) {
                                    Label("刪除頁面", systemImage: "minus")
                                }
                            })
                        }
                HStack {
                    Button("+"){
                        let a = pages.count - 1
                        pages.insert("內容\(a)", at: a)
                    }
                    Button("-"){
                        let a = pages.count - 2
                        pages.remove(at: a)
                    }
                    
                }
            
            
    } detail: {
        VStack(alignment: .leading){
            ContentView2(頁面: 頁面(內容頁面: $顯示頁面))
            
        }
        
    }
        
    }
    func insertPage(after page: String, page2: String) {
            if let index = pages.firstIndex(of: page) {
                pages.insert(page2, at: index + 1)
            }
        }
        
        func removePage(at index: Int) {
            pages.remove(at: index)
        }
}

