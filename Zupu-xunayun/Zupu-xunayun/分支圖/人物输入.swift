//
//  人物输入.swift
//  S軒轅族譜
//
//  Created by 火靈 鳥 on 2024/1/1.
//

import Foundation
import SwiftUI
struct 成員輸入介面: View {
    //@EnvironmentObject private var 用戶數據: 共用數據
    
    @Binding var 人員分支數據:成員數據
    @Binding var 菜單:Bool
    @State var 性別:Bool = true
    @State private var 標題 = "軒轅族譜成員管理"
    //@State private var 配偶信息: [成員數據] = []
    @State private var 配偶姓名 = ""
    @State private var 子女姓名 = ""
    @State private var 出生時間 = ""
    @State private var 死亡時間 = ""
    @State private var 健在 = true
    
    var body: some View {
        VStack {
            Text("族譜人員編輯")
                .font(.title)
            輸入框(標題內容: "姓名", 內容: $人員分支數據.姓名)
            HStack {
                輸入框(標題內容: "出生時間", 內容: $出生時間)
                Toggle(isOn: $健在) {
                    Text("健在")
                }
                if 人員分支數據.父親.last == "妻"{
                   Spacer()
                }else{
                    Toggle(isOn: $性別) {
                        Text("男性")
                    }
                }
                
            }
            if !健在 {
                輸入框(標題內容: "逝世時間", 內容: $死亡時間)
            }
            if 人員分支數據.父親.last == "妻"{
               Spacer()
            }else{
                VStack{
                    Text("配偶")
                    HStack{
                        TextField("", text: $配偶姓名)
                        Button("添加"){
                            人員分支數據.添加配偶(配偶姓名)
                        }
                    }
                    List(人員分支數據.配偶) { index in
                        HStack {
                            Text("\(index.姓名)")
                            Spacer()
                            Button(action: {
                                人員分支數據 = index
                                //成員輸入介面($index, $菜單)
                            }) {
                                Text("编辑")
                            }
                            Button(action: {
                                人員分支數據.刪除配偶(index.id)
                            }) {
                                Text("刪除")
                            }
                        }
                    }
                    Text("子女")
                    HStack{
                        TextField("", text: $子女姓名)
                        Button("添加"){
                            人員分支數據.添加子女(子女姓名)
                        }
                    }
                    List(人員分支數據.子女) { index in
                        HStack {
                            Text("\(index.姓名)")
                            Spacer()
                            Button(action: {
                                人員分支數據.刪除子女(index.id)
                            }) {
                                Text("刪除")
                            }
                        }
                    }
                }
                
            }
            
            
            TextEditor(text: $人員分支數據.簡介)
                .textFieldStyle(.plain)
        }.frame(minHeight: 500, idealHeight: 600, maxHeight: 720)
        HStack{
            Button("更新簡介"){
                
                    
                    人員分支數據.生成簡介(出生時間: 出生時間, 死亡時間: 死亡時間, 健在: 健在, 女性: 性別)
                    if 人員分支數據.父親.last == "妻"{
                        人員分支數據.簡介 = "\(人員分支數據.父親)\n" + 人員分支數據.簡介
                    } else {
                        if 性別 {人員分支數據.簡介 = "\(人員分支數據.父親)之子\n"+人員分支數據.簡介}
                        else
                        {人員分支數據.簡介 = "\(人員分支數據.父親)之女\n"+人員分支數據.簡介}
                    
                }
                
                
            }
            Button("保存人員"){
                菜單.toggle()
            }
            
        }
    }
    
    init (人員分支數據:Binding<成員數據>,菜單:Binding<Bool>){
        _人員分支數據 = 人員分支數據
        _菜單=菜單
    }
}




