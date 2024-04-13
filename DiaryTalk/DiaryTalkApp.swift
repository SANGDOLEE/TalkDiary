
import SwiftUI
import SwiftData

@main
struct DiaryTalkApp: App {
    
    var modelContainer: ModelContainer = {
        let schema = Schema([Memo.self, Tag.self, Chat.self, ChatTag.self])
          let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
          
          do {
              return try ModelContainer(for: schema, configurations: [modelConfiguration])
          } catch {
              fatalError("Could not create ModelContainer: \(error)")
          }
      }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(modelContainer)
        }
    }
}
