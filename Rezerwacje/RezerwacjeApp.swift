import SwiftUI

@main
struct RezerwacjeApp: App {
    var network = Network()
    var body: some Scene {
        WindowGroup {
            LoginPageView()
                .environmentObject(network)
        }
    }
}
