import Foundation
/// Dateの拡張
extension Date {
    /// JSTタイムゾーン
    private static var jst: TimeZone {
        TimeZone(identifier: "Asia/Tokyo")!
    }
    
    /// カレンダー(JST)
    static var jstCalendar: Calendar {
        var calender: Calendar = .init(identifier: .gregorian)
        calender.timeZone = jst
        return calender
    }
    
    /// 「今日」の年月日を返す(JST)
    /// - note: 時間は00:00:00
    static var todayJST: Date {
        jstCalendar.startOfDay(for: Date())
    }
}
