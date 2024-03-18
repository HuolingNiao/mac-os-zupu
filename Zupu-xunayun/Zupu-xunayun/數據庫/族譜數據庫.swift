import SwiftUI
class 數據庫: ObservableObject  {
    @Published var 族譜數據 = 成員數據(姓名: "始祖")
    private func 查找(ID: UUID) -> 成員數據 {
        return (族譜數據.查找(by: ID) ?? 族譜數據)
    }
    func 轉換查找(ID: UUID) -> 人員 {
        let a = 查找(ID:ID)
        let b = 人員(id: a.id, 姓名: a.姓名, 世代: a.世代)
        return b
    }
}
