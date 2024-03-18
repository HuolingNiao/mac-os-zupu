//
//  歡迎.swift
//  S軒轅族譜
//
//  Created by 火靈 鳥 on 2023/12/20.
//

import Foundation
import SwiftUI
import Combine

class 共用數據: ObservableObject {
    @Published var 封面標題 = "溫氏族譜"
    @Published var 字輩:String = "子鳳名以璠元鴻啟光照大德朝廷重明賢遠進親國家能當用禮儀表君平"
    
    
    @Published var 成員庫 = 成員數據(姓名: "始祖")
    //@Published var 編輯人員 = 成員數據(姓名: "")
    
    @Published var 配偶顯示 = true
    @Published var 成員文本:[String] = [""]
    @Published var 成員頁面文本:[[String]] = [[""],[""]]
    
    func 保存(){
        成員庫.保存()
    }
    func 讀取(){
        成員庫 = 成員庫.讀取() ?? 成員數據(姓名: "出錯了")
    }
    
    func 更新成員文本(){
        成員文本 = 成員庫.成員文本()
        成員頁面文本 = 成員文本.拆分(by: 7)
        if (成員頁面文本.count % 2) != 0 {
            成員頁面文本.append([""])
        }
    }
}

struct 書籍 {
    var 封面標題 = "溫氏族譜"
    var 字輩:String = "子鳳名以璠元鴻啟光照大德朝廷重明賢遠進親國家能當用禮儀表君平"
    var 前言:[String] = [
         """
    序言一
    夫古風流轉蘊含濃郁文化其熏陶氛圍無不滲入於諸多家族之中族譜蓋乃家族之根基亦為家族歷史之記憶更為對昔日之敬仰與對來者之承傳
    秋風飄揚落葉歸根中國文化蘊藏之深意亦莫不如此異鄉之子孫心懷追尋祖源之情懷無論身處何方惟念故鄉之風土民情思慕昔日之家園此種異地思鄉之情激勵其對家族傳統之尊重與堅守
    大家小家則為社會之根基於是時家族為社會之本大家則為家族之心而小家則為大家之延族譜中載錄諸人姓名、生辰八字、事蹟等此等資訊不僅為個人之紀念更為家族之記憶透過族譜人得以了解血脈相承感受家族之凝聚力與歷史之厚重
    傳統文化乃中國人之珍貴財富亦為我們之根本所在族譜為其中之一環肩負著家族歷史與文化傳承之重任其非止為家族之記錄更為時代之見證斯乃載錄昔日輝煌與艱辛之文字彰顯中國人之智慧與勤奮
    於急速變遷之時代我等當更重視且承傳此等傳統文化族譜之編纂與傳承為我等對祖先之敬意亦為對後代之責任使我等共同努力將此傳統文化代代相傳使每一人皆能感受家族之溫暖與力量使我等之根深深於斯土永不忘初心承傳中國之傳統文化
    謹此獻上
    """,
         """
     序言二
     夫吾溫氏源遠流長自古以來其姓氏起源蓋由來已久相傳我族之先祖得賜名「溫」乃以其人品溫和、才華出眾而得此美名自此以來溫氏家族薪火相傳綿延不絕世代相承將家族之榮耀傳於後世
     自古以來溫氏家族涌現諸多傑出之人彰顯家族之聲望先祖溫仲堅曾為唐代名將英勇善戰威震敵胡聲名遠播溫庭筠則為唐代文學家其詩文樸實優雅被譽為「詩聖」文名遠揚此等名人為溫氏家族增添了光彩成為後世之楷模
     時至今日溫氏家族猶如飛龍鎮迴龍灣之一枝獨秀繁榮興盛飛龍鎮環境幽美山水秀麗而迴龍灣更是其瑰寶所在溫氏家族作為此地的重要一員以家族的凝聚力和智慧積極參與當地的經濟發展與社會事務為飛龍鎮的繁榮作出了卓越貢獻
     值此日我謹以此序表達對溫氏家族的敬意與祝福願溫氏家族的根深深扎於這片土地永遠不忘先祖的智慧與堅毅繼續傳承中國傳統文化為家族的繁榮與社會的進步做出更大的貢獻
     敬祝家族興旺世代繁衍
     謹此敬上
     """,
         """
         序言三
         我族歷史悠久因各種歷史原因祠堂牌匾族譜皆未留存於世今四處奔走搜集紀錄整理成冊望流傳後人
         康熙初年我族老祖溫子慶自祖籍湖北省麻城縣孝感鄉椒困屋上川三世祖溫名揚落業富順縣洪合鄉南菜子屋基早年因生活困苦和諸多歷史原因致使族薄不全錯漏眾多又因譜稿跟不上氏族發展因而族譜譜上有名又無後人發展情況者眾多例如四世祖溫以讓韋氏生三子譜上僅紀錄有溫璠等等原因 致使九代光輩函接有誤至清朝嘉慶因光輩記載不詳致使照輩混亂現今照輩氏族眾多分佈較廣岩鷹洞螯山天生天池廣福等處德輩氏族兄弟皆說爺輩為照輩又不明祖輩之名若不及時修譜同族宗親皆相見不相識相識不相認極大有損我族家風辜負老祖前輩養育之恩同時警示現今我族同胞加強對後人家族觀念對教育教育後人團結友愛把家族理念發揚光大
         時至二零一二年德朝二輩蓬勃發展之期為了讓溫氏家族更加繁盛和睦現將殘留小冊作一整理若有勘誤還望諒解
         溫明高-德輩-二零一二年清明 敬上
         """
    ]
    var 字輩頁面 = """
溫氏家族三十輩五字句
子鳳名以璠
元鴻啟光照
大德朝廷重
明賢遠進親
國家能當用
禮儀表君平
二零二四年本族已發展至十六輩-重
"""
    var 後記 = """
後記
在整理族譜的过程中我們深切感受到了家族的歷史悠久和寶貴儘管歷史的洪流和各種不可抗力使得祠堂牌匾和許多族譜遺失但我們並沒有放棄而是勇往直前四處奔走搜集紀錄努力將這份寶貴的遺產整理成冊以期能夠流傳給後人
我們追溯到康熙初年的老祖溫子慶他從湖北省麻城縣孝感鄉椒困屋上川經歷了艱辛的生活和種種困難最終在富順縣洪合鄉南菜子屋基落地生根然而由於生活困苦和歷史的曲折我們的族譜在記錄上出現了許多遺漏和錯誤這對我們的家族風氣和我們對前輩養育之恩的回報都是巨大的損失因此我們呼籲現今的族人們要加強對後人的家族觀念注重教育並教育後代團結友愛將家族的理念發揚光大
世祖溫公夫婦之墓由於年代久遠物質文化落後人民物質生活難以保障的情況下祖墳無人問津加之人畜踐踏現今幾乎淪為平地最初的碑文已被損毀當時二祖兩墳現今合為一墳
現在國家政策支持物質文化豐富的前提下在少數族人提議下希望將座落於富順縣飛龍鎮餘豐村溫子慶夫婦之墳合為一墳因不知世祖夫婦生辰為便於雕刻碑文現建議編制如下正中-溫公諱子慶始祖夫婦之墓-右邊為立碑時間左邊溫氏宗親-大-德-朝-庭四代共立
最後我們要衷心感謝所有為整理族譜而努力奔走的人他們的辛勤付出和無私奉獻使得這個族譜得以重見天日也感謝所有支持和關心我們工作的宗親們正是因為你們的支持和鼓勵我們才能堅持不懈地進行這項工作希望這份整理出來的族譜能夠成為我們家族的寶貴財富傳承下去遠流傳於世
祈願我們溫氏家族的輝煌歷史能夠激勵我們後人讓我們團結一心共同發展繼續傳承和發揚我們家族的優良傳統
再次感謝大家！
溫氏家族 敬上
"""
    
    @MainActor
        func pdf(內容:some View){
            let a = ImageRenderer(content: 內容)
            a.scale = 2
            let url = URL.documentsDirectory.appending(path: "族譜.pdf")
            a.render { size, context in
                // 4: 指定 PDF 的大小；
                var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                
                // 5: 创建一个 CGContext 对象来处理 PDF 页面
                guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                    return
                }
                pdf.beginPDFPage(nil)
                
                // 7: 将 SwiftUI 视图渲染到该页面上
                context(pdf)
                
                // 8: 结束页面并关闭 PDF 文档；
                pdf.endPDFPage()
                pdf.closePDF()
            }
                
        }
        @MainActor
        func png(內容:some View){
            let a = ImageRenderer(content: 內容)
            let c = a.nsImage?.tiffRepresentation
            let b = 文件管理()
            b.另存為(數據:c! , 文件夾: "族譜緩存", 文件名: "1.tiff")
        }
}
