//
//  SupportMailData.swift
//  NetworkTest
//
//  Created by Arslan Abdullaev on 16.04.2022.
//

import Foundation
import UIKit

struct ComposeMailData {
  let subject: String
  let recipients: [String]?
  let message: String
    
  let attachments: [AttachmentData]?
}

struct AttachmentData {
  let data: Data
  let mimeType: String
  let fileName: String
 
}

class DeviceData {
    var deviceData: String = """
            Application Name: \(Bundle.main.displayName)
            iOS: \(UIDevice.current.systemVersion)
            Device Model: \(UIDevice.current.modelName)
            Appp Version: \(Bundle.main.appVersion)
            App Build: \(Bundle.main.appBuild)
        --------------------------------------
        """
}
