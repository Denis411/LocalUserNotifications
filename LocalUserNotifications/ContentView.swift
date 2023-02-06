//
//  ContentView.swift
//  LocalUserNotifications
//
//  Created by Dennis Programmer on 6/2/23.
//

import SwiftUI
import UserNotifications

class ContentViewModel: ObservableObject {
    @Published var notificationDelay: String = "5"

    func askForNotificationPermission() {
        let options: UNAuthorizationOptions = [.badge, .sound, .alert]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let _ = error {
                print("⚠️ Notification permission has not been granted")
            } else {
                print("✅ Notification permission has been granted")
            }
        }
    }

    func scheduleAlertWithDelay() {
        guard let delay = Double(notificationDelay) else {
            print("⚠️ Text is to convertible to Int")
            return
        }

        let content = UNMutableNotificationContent()
        content.title = "Title:  Delay for" + notificationDelay
        content.subtitle = "Subtitle"
        content.sound = .defaultRingtone
        content.badge = 1

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: delay,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content ,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let _ = error {
                print("⚠️ Notification has not been received",
                      error!.localizedDescription)
                return
            }

            print("✅ Notification has been received")
        }
    }
}

struct ContentView: View {
    @ObservedObject var vm = ContentViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Button("Ask for permission") {
                vm.askForNotificationPermission()
            }
            .background(Color.gray)

            TextField("Minutes of delay", text: $vm.notificationDelay)

            Button("Schedule notification") {
                vm.scheduleAlertWithDelay()
            }
            .background(Color.gray)
        }
        .background(Color.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
