import SwiftUI
/// EnvironmentValuesの拡張
extension EnvironmentValues {
    /// ローディング
    var loading: LoadingActions {
        get { self[LoadingActionsKey.self] }
        set { self[LoadingActionsKey.self] = newValue }
    }
    
    struct LoadingActionsKey: EnvironmentKey {
        static let defaultValue = LoadingActions(show: {}, hide: {})
    }

    struct LoadingActions {
        let show: @MainActor () -> Void
        let hide: @MainActor () -> Void
    }
    /// カスタムダイアログ
    var dialog: DialogActions {
        get { self[DialogActionsKey.self] }
        set { self[DialogActionsKey.self] = newValue }
    }
    
    struct DialogActionsKey: EnvironmentKey {
        static let defaultValue = DialogActions(show: {}, hide: {}, onCheck: {}, onClose: {})
    }

    struct DialogActions {
        /// ダイアログを表示する処理
        let show: @MainActor () -> Void
        /// ダイアログを非表示にした際の処理
        let hide: @MainActor () -> Void
        /// ダイアログのチェックボックスをチェックした際の処理
        let onCheck: @MainActor () -> Void
        /// ダイアログの閉じるボタンをタップした際の処理
        let onClose: @MainActor () -> Void
    }
    /// アラート(.alert)
    var alert: AlertActions {
        get { self[AlertActionsKey.self] }
        set { self[AlertActionsKey.self] = newValue }
    }
    
    struct AlertActionsKey: EnvironmentKey {
        static let defaultValue = AlertActions(show: {_ in }, hide: {}, onTapOKButton: {}, onTapCancelButton: {})
    }
    
    struct AlertActions {
        /// アラートを表示する処理
        let show: @MainActor (AlertContent) -> Void
        /// アラートを非表示にした際の処理
        let hide: @MainActor () -> Void
        /// OKボタンタップ時処理
        let onTapOKButton: @MainActor () -> Void
        /// キャンセルボタンタップ時処理
        let onTapCancelButton: @MainActor () -> Void
    }
}


