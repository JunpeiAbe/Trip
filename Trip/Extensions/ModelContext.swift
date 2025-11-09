import Foundation
import SwiftData
/// ModelContextの生成を簡略化する便利拡張
extension ModelContext {
    enum StorageType {
        case inMemory
        case file
    }
    
    convenience init(
        for types: any PersistentModel.Type,
        storageType: StorageType = .inMemory,
        shouldDeleteOldFile: Bool = false,
        fileName: String = #function
    ) throws {
        // 1. モデル定義のメタタイプでSchemaを初期化
        let schema: Schema = Schema([types])
        
        let sqliteURL = URL.documentsDirectory.appending(component: fileName).appendingPathExtension("sqlite")
        
        // ファイルストレージの DB を削除するかで
        // これは動作確認をする上で設けています。
        if shouldDeleteOldFile {
            let fileManager = FileManager.default
            
            if fileManager.fileExists(atPath: sqliteURL.path) {
                try fileManager.removeItem(at: sqliteURL)
            }
        }
        // 2. SchemaでModelConfigurationを初期化
        let modelConfiguration: ModelConfiguration = {
            switch storageType {
            case .inMemory:
                // ファイルストレージを使用せずにメモリのみで SwiftData を扱う
                ModelConfiguration(
                    schema: schema,
                    isStoredInMemoryOnly: true
                )
            case .file:
                // ファイルストレージに永続化するための url を指定
                ModelConfiguration(
                    schema: schema,
                    url: sqliteURL
                )
            }
        }()
        // 3. ModelConfiguration で ModelContainer を初期化
        let modelContainer = try ModelContainer(
            for: schema,
            configurations: [modelConfiguration]
        )
        
        // 4. ModelContainer で ModelContext を初期化
        self.init(modelContainer)
    }
    
    func fetch<Model>(
        for type: Model.Type
    ) throws -> [Model] where Model: PersistentModel {
        try fetch(.init())
    }
    
    func fetchCount<Model>(
        for type: Model.Type
    ) throws -> Int where Model: PersistentModel {
        try fetchCount(FetchDescriptor<Model>())
    }
}
