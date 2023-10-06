//
//  URLExtension.swift
//  Targets
//
//  Created by Sferea-Lider on 05/10/23.
//

import Foundation
import MobileCoreServices

extension URL {
    
    func mimeType() -> String {
        let pathExtension = self.pathExtension
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    
    var containsImage: Bool {
            let mimeType = self.mimeType()
            guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
                return false
            }
            return UTTypeConformsTo(uti, kUTTypeImage)
    }
}
