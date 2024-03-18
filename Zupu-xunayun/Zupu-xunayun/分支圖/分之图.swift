//
//  分之图.swift
//  S軒轅族譜
//
//  Created by 火靈 鳥 on 2024/1/1.
//

import SwiftUI



struct 分支樹編輯<V: View>: View {
    @EnvironmentObject private var 用戶數據: 共用數據
    @Binding var 樹: 成員數據
    let 節點: (String) -> V
    typealias Key = 位置<UUID, Anchor<CGPoint>>
    @State var 編輯 = false
    @State var 子女編輯 = false
    @State var 配偶編輯 = false
    @State var 配偶顯示 = false
    @State var 新子女姓名: String = ""
    var body: some View {
        VStack(spacing: 20) {
            HStack(alignment: .top){
                節點(樹.姓名)
                    .anchorPreference(key: Key.self, value: .top) {
                        [self.樹.id: $0]
                    }
                if 用戶數據.配偶顯示 {
                    HStack(alignment: .top){
                        ForEach($樹.配偶) { 分支 in
                            分支樹編輯(樹: 分支, 節點: self.節點)
                                .modifier(中文風格(字號: 20, 字體: .康熙))
                                .onLongPressGesture {
                                    樹.刪除配偶(分支.id)
                                }
                            
                        }
                    }
                }
                
            }
            
                .onTapGesture(count: 2) {
                    //用戶數據.成員庫.更新當前人員(id: 樹.id)
                    編輯.toggle()
                }
                .contextMenu {
                    Button(action: {
                        編輯.toggle()
                    }) {
                        Text("編輯人員")
                        Image(systemName:  "square.and.pencil")
                    }
                    Button(action: {
                        配偶編輯.toggle()
                    }) {
                        Text("添加配偶")
                        Image(systemName: "plus")
                    }
                    
                    Button(action: {
                        子女編輯.toggle()
                    }) {
                        Text("添加子女")
                        Image(systemName: "plus")
                    }
                    Button(action: {
                        用戶數據.配偶顯示.toggle()
                    }) {
                        Text("隱藏/顯示配偶")
                        //Image(systemName: "plus")
                    }
                    if 樹.id == 用戶數據.成員庫.id {
                        Button(action: {
                            用戶數據.成員文本 = 樹.成員文本()
                        }) {
                            Text("保存")
                            //Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $編輯) {
                    
                    成員輸入介面(人員分支數據: $樹, 菜單: $編輯)
                }
                .sheet(isPresented: $子女編輯) {
                    添加子女视图(新子女姓名: $新子女姓名) {
                     樹.添加子女(新子女姓名)
                     子女編輯.toggle()
                     }
                }
                .sheet(isPresented: $配偶編輯) {
                    添加子女视图(新子女姓名: $新子女姓名) {
                     樹.添加配偶(新子女姓名)
                     配偶編輯.toggle()
                     }
                }
            
            HStack(alignment: .top, spacing: 10) {
                ForEach($樹.子女) { 分支 in
                    分支樹編輯(樹: 分支, 節點: self.節點)
                        .onTapGesture(count: 2) {
                            //用戶數據.成員庫.更新當前人員(id: 樹.id)
                            編輯.toggle()
                        }
                        .onLongPressGesture {
                            樹.刪除子女(分支.id)
                        }
                }
            }
        }
        .backgroundPreferenceValue(Key.self) { (centers: [UUID: Anchor<CGPoint>]) in
            GeometryReader { proxy in
                ForEach(self.樹.子女) { child in
                    線條(起點: proxy[centers[self.樹.id]!],
                       終點: proxy[centers[child.id]!])
                    .stroke(lineWidth: 2)
                }
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}

struct 位置<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key: Value] { [:] }
    
    static func reduce(value: inout [Key: Value], nextValue: () -> [Key: Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

struct 線條: Shape {
    var 起點: CGPoint
    var 終點: CGPoint
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: 起點)
        path.addLine(to: CGPoint(x: 起點.x, y: 終點.y * 0.9))
        path.addLine(to: CGPoint(x: 終點.x, y: 終點.y * 0.9))
        path.addLine(to: 終點)
        
        return path
    }
}

struct 添加子女视图: View {
    @Binding var 新子女姓名: String
    var 添加子女操作: () -> Void
    
    var body: some View {
        VStack {
            TextField("请输入姓名", text: $新子女姓名)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("确认") {
                if !新子女姓名.isEmpty {
                    添加子女操作()
                }
            }
            .padding()
        }
    }
}

extension 成員數據 {
    func 提取同一世代成員樹組() -> [[成員數據]] {
        var 樹組: [[成員數據]] = []
        提取同一世代成員樹組(樹組: &樹組)
        return 樹組
    }
    
    private func 提取同一世代成員樹組(樹組: inout [[成員數據]]) {
        if 世代 > 樹組.count {
            樹組.append([])
        }
        樹組[世代 - 1].append(self)
        
        for 孩子成員 in 子女 {
            孩子成員.提取同一世代成員樹組(樹組: &樹組)
        }
    }
}
struct 分支視圖: View {
    @Binding var 分支數據: 成員數據
    
    var body: some View {
        分支樹編輯(樹: $分支數據){ a in
            Text("\(a)")
                .modifier(中文風格(字號: 18, 字體: .康熙))
                .foregroundColor(Color.black)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 0)
                   
                        .fill(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 2)
                            
                        )
                )

        }
    }
}

