//
//  PDF相關.swift
//  Zupu-xunayun
//
//  Created by 火靈 鳥 on 2024/1/8.
//

import SwiftUI
import PDFKit

struct ContentView2: View {
    @State var  菜單 = false
    @State var showPDFPreview = false
    @State var 頁面:頁面
    @State var pdfDocument: PDFDocument?
    //@State var z:NSImage
    var body: some View {
        VStack{
            HStack(spacing:10){
                Button(action: {
                    頁面.用戶數據.成員庫 = 成員數據(姓名: "始祖")
                    頁面.用戶數據.更新成員文本()
                    // 刪除功能
                }) {
                    HStack{
                        Text("新建族譜")
                        Image(systemName: "doc")}
                }
                
                
                Button(action: {
                    // 保存功能
                    頁面.用戶數據.保存()
                }) {
                    HStack{
                        Text("保存族譜")
                        Image(systemName: "square.and.arrow.down")}
                }
                Button(action: {
                    菜單.toggle()
                    // 保存功能
                    //頁面.用戶數據.讀取()
                    //頁面.用戶數據.更新成員文本()
                }) {
                    HStack{
                        Text("讀取族譜")
                        Image(systemName: "square.and.arrow.down.fill")}
                }
                Button("導出 PDF") {
                    導出PDF()
                }
                     
            }.frame(height: 35)
            ScrollView{
                頁面}
        }.sheet(isPresented: $菜單){
            读取界面(用戶數據: 頁面.用戶數據, 菜單: $菜單)
        }
       
    }
    
    @MainActor func 導出PDF(){
        let 預設文件名 = "族譜"
            var 文件名 = 預設文件名
            var 文件序號 = 1

            func 生成文件URL() -> URL {
                let 下載目錄URL = URL.downloadsDirectory
                var 文件URL = 下載目錄URL.appendingPathComponent("\(文件名).pdf")

                while FileManager.default.fileExists(atPath: 文件URL.path) {
                    文件序號 += 1
                    文件名 = "\(預設文件名)\(文件序號)"
                    文件URL = 下載目錄URL.appendingPathComponent("\(文件名).pdf")
                }

                return 文件URL
            }
            let renderer = ImageRenderer(content: 頁面)
        renderer.scale = 2
            //let a = renderer.nsImage
            renderer.render { size,context in
                var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                guard let pdf = CGContext(生成文件URL() as CFURL,mediaBox: &box,nil) else {return}
                pdf.beginPDFPage(nil)
                context(pdf)
                pdf.endPage()
                pdf.closePDF()
                if let document = PDFDocument(url: 生成文件URL()) {
                    pdfDocument = document
                    showPDFPreview = true
                }
        }
    }
}

struct PDFPreview: NSViewRepresentable {
    let pdfDocument: PDFDocument

    func makeNSView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        return pdfView
    }

    func updateNSView(_ nsView: PDFView, context: Context) {
        // No need to update the view in this case
    }
}

