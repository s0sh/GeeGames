//
//  HTMLView.swift
//  GeeGames
//
//  Created by Roman Bigun on 19.11.2023.
//

import SwiftUI

#Preview {
    HTMLText()
}

struct HTMLText: View {
    
    @State var html = "<html><body><span style=\"font-family: '-apple-system', 'Helvetica-Black'; font-size: 22\">Hello World!</span></body></html>"
    
    var body: some View {
        
        if let nsAttributedString = try? NSAttributedString(data: Data(html.utf8),
                                                            options: [.documentType: NSAttributedString.DocumentType.html],
                                                            documentAttributes: nil),
           let attributedString = try? AttributedString(nsAttributedString, including: \.uiKit) {
            
            Text(attributedString).background(SwiftUI.Color.white)
            
        } else {
            // fallback...
            Text(html)
        }
    }
}

struct HTMLExample {
    @State var html: String = ""

    var attributedHtml: NSAttributedString {
        let html: String = "<html><body><span style=\"font-family: '-apple-system', 'Helvetica'; font-size: 14\">\(self.html)</span></body></html>"
        
        guard let data = html.data(using: String.Encoding.utf8, allowLossyConversion: false) else {
            return NSAttributedString(string: "")
        }
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
            ]
            
                if let result = try? NSAttributedString(data: data,
                                                        options: options,
                                                        documentAttributes: nil) {
                    return result
                }
            
            return NSAttributedString(string: html)
        } catch {
            return NSAttributedString(string: "")
        }
    }
}
