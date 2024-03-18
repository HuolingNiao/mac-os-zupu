//
//  分之图页面基本.swift
//  Zupu-xunayun
//
//  Created by 火靈 鳥 on 2024/1/18.
//

import Foundation
import SwiftUI

struct 分支樹<V: View>: View {
    @State var 配偶 = true
    @State var 樹: 成員數據
    let 節點: (String) -> V
    typealias Key = 位置<UUID, Anchor<CGPoint>>
   
    var body: some View {
        VStack(spacing: 20) {
            HStack(alignment: .top){
                節點(樹.姓名)
                    .anchorPreference(key: Key.self, value: .top) {
                        [self.樹.id: $0]
                    }
                if 配偶 {
                    HStack(alignment: .top){
                        ForEach(樹.配偶) { 分支 in
                            Text("娶-"+分支.姓名)
                                .modifier(中文風格(字號: 14, 字體: .康熙))
                        }
                    }
                }
            }
            HStack(alignment: .top, spacing: 10) {
                ForEach(樹.子女) { 分支 in
                    分支樹(樹: 分支, 節點: self.節點)
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
struct 分支页面圖: View {
    @Binding var 分支數據: 成員數據
    
    var body: some View {
        分支樹(樹: 分支數據){ a in
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
