import SwiftUI
import GhostStrings

@main
struct GhostStringsShowcaseApp: App {
    init() {
        #if DEBUG
        let projectId = "dk_5c22c59fc93e46e588fecb22"
        #else
        let projectId = "pk_c3c79738fe5643c0a3432fe4"
        #endif

        GhostStrings.shared.initSDK(config: GhostStringsConfig(
            projectId: projectId,
            baseUrl: "https://api.ghoststrings.ai",
            debugMode: true
        ))
    }
    
    var body: some Scene {
        WindowGroup {
            GhostStringsProvider {
                ContentView()
            }
        }
    }
}
