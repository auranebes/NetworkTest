//
//  SupportMailView.swift
//  NetworkTest
//
//  Created by Arslan Abdullaev on 16.04.2022.
//

import SwiftUI


struct SupportMailView: View {

   @State var mailData = ComposeMailData(subject: "Тема:",
                                                 recipients: ["ars352@yahoo.com"],
                                                 message: "Ваше предложение: ",
                                         attachments: [AttachmentData(data: """
                                                                  "
                                                                      Application Name: \(Bundle.main.displayName)
                                                                      iOS: \(UIDevice.current.systemVersion)
                                                                      Device Model: \(UIDevice.current.modelName)
                                                                      Appp Version: \(Bundle.main.appVersion)
                                                                      App Build: \(Bundle.main.appBuild)
                                                                  --------------------------------------
                                                                  """
                                                                            .data(using: .utf8)!,
                                                                              mimeType: "text/plain",
                                                                              fileName: "text.txt"
                                                                              )
                                                 ])
   @State private var showMailView = false
    

    var body: some View {
        Button(action: {
            showMailView.toggle()
        }) {
            Text("Отправить")
        }
        .disabled(!MailView.canSendMail)
        .sheet(isPresented: $showMailView) {
            MailView(data: $mailData) { result in
                print(result)
            }
        }
    }
}
