//
//  視圖組件.swift
//  軒轅族譜
//
//  Created by 火靈 鳥 on 2023/12/16.
//

import Foundation
import SwiftUI

struct 輸入框: View {
    var 標題內容:String
    @Binding var 內容:String
    var body: some View {
        HStack {
            Text(標題內容)
            TextField("", text: $內容)
                .textFieldStyle(.roundedBorder)
        }
    }
}

struct 性別: View {
    let 性 = ["男","女"]
    @State var 男女 = 0
    var body: some View {
        Picker(selection: $男女,label: Text("性別")){
            
            ForEach( 性.indices,id: \.self){ a in
                Text(性[a])
            }
        }
    }
}

