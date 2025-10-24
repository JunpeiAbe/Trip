import Foundation
/// Calendarの拡張（日時作成用）
extension Calendar {
    /// 年月日からDateを生成
    func date(
        year: Int,
        month: Int,
        day: Int,
        hour: Int = 0,
        minute: Int = 0,
        second: Int = 0
    ) -> Date? {
        let components = DateComponents(
            calendar: self,
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute,
            second: second
        )
        return self.date(from: components)
    }
    /// 日本時間（JST: Asia/Tokyo）のCalendar（Gregorian, ja_JP）
    /// 必要なときに毎回新しいインスタンスを返す
    static var jstCalendar: Calendar {
        var calender = Calendar(identifier: .gregorian)
        calender.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        calender.locale = Locale(identifier: "ja_JP")
        return calender
    }
}
