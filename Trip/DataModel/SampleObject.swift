import Foundation
@MainActor
class SampleObject {
    // SampleObjectがMainActorで隔離されているため、メインスレッドで実行される
    func run() {
        print("\(#function): \(Thread.unsafeCurrent)")
    }
    // SampleObjectがMainActorで隔離されているため、メインスレッドで実行される
    func runAsync() async {
        print("\(#function): \(Thread.unsafeCurrent)")
    }
    // MainActorで隔離されているが、`@concurrent`を付与しているので別スレッドで実行される
    @concurrent func runAsyncConcurrent() async {
        print("\(#function): \(Thread.unsafeCurrent)")
    }
    // MainActorで隔離されておらず実行元のスレッドで実行される
    nonisolated func runNonisolated() {
        print("\(#function): \(Thread.unsafeCurrent)")
    }
    // MainActorで隔離されておらず実行元スレッド以外のスレッドで実行される
    /// - note: Swift6.2より「nonisolatedな同期関数(runNonisolated)は実行元スレッドで動作するのにnonisolatedな非同期関数だけ別スレッドで動作するのは理解が難しい」という理由で両方とも呼び出しもとのスレッド動作する挙動に変わった
    /// nonisoated(nonsending) by DefaultをYESに変更する
    nonisolated func runNonisolatedAsync() async {
        print("\(#function): \(Thread.unsafeCurrent)")
    }
    // MainActorで隔離されていない + `@concurrent`を付与しているので、実行元スレッド以外のスレッドで実行される
    @concurrent nonisolated func runNonisolatedAsyncConcurrent() async {
        print("\(#function): \(Thread.unsafeCurrent)")
    }
}

