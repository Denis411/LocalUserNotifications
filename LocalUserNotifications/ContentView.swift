//
//  ContentView.swift
//  LocalUserNotifications
//
//  Created by Dennis Programmer on 6/2/23.
//

import SwiftUI
import UserNotifications

class ContentViewModel: ObservableObject {
    func askForNotificationPermission() {
        let options: UNAuthorizationOptions = [.badge, .sound, .alert]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let _ = error {
                print("⚠️ Notification permission has not been granted")
            } else {
                print("⚠️ Notification permission has been granted")
            }
        }
    }

}

struct ContentView: View {
    let vm = ContentViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Button("Ask for permission") {
                vm.askForNotificationPermission()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
