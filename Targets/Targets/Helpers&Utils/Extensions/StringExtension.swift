//
//  StringExtension.swift
//  Colonos
//
//  Created by Sferea-Lider on 19/01/22.
//

import Foundation
import CommonCrypto
import UIKit
 
extension String {
    
    public var sha256: String {
        let data = Data(utf8)
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes { buffer in
            _ = CC_SHA256(buffer.baseAddress, CC_LONG(buffer.count), &hash)
        }
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
    /// String con solo digitos.
    var digits: String {
        components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    func isValidData(validType: TextValidation) -> Bool{
        return validType.rawValue.validateData(textToValidate: self)
    }
    
    func validateData(textToValidate: String) -> Bool{
        let p = NSPredicate(format: "SELF MATCHES %@", self)
        return p.evaluate(with: textToValidate)
    }
    
    func stripOutHtml() -> String? {
        do {
            guard let data = self.data(using: .unicode) else {
                return nil
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string//attributed.string.replacingOccurrences(of: "\n", with: " ")
        } catch {
            return nil
        }
    }
    
    func htmlToAttributedString(size: String = "15") -> NSAttributedString? {
        let modifiedString = "<link href='https://fonts.googleapis.com/css2?family=Open-Sans:ital' rel='stylesheet'><style>body{font-family: 'Montserrat', sans-serif; font-size: \(size)px;}</style>\(self)";
        guard let data = modifiedString.data(using: .utf8) else { return NSAttributedString() }
       
        var attribStr = NSMutableAttributedString()
       
        do {
            attribStr = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)

        } catch {
            print(error)
        }
        return attribStr
    }
    
    public func getAttString(att: [NSAttributedString.Key:Any]) -> NSMutableAttributedString{
        return NSMutableAttributedString(string: self,attributes: att)
    }

    /*func getUnderline(words: [String]) -> NSMutableAttributedString{
        let normalAtt: [NSAttributedString.Key: Any] = [.font : UIFont.openSans.medium.of(size: 14),
                                                        .foregroundColor : UIColor.blackClub]
        let startText = self.getAttString(att: normalAtt)
        for word in words {
            startText.makeGreen(word: word)
        }
        return startText
    }
    */
    
    /*func getCurrency(color: UIColor = .green) -> NSMutableAttributedString{
        let normalAtt: [NSAttributedString.Key: Any] = [.font : UIFont.openSans.bold.of(size: 16),
                                                        .foregroundColor : color]
        let startText = self.getAttString(att: normalAtt)
        let greenAtt:[NSAttributedString.Key:Any] = [.font: UIFont.openSans.bold.of(size: 12),
                                                     .foregroundColor: color]
        startText.add(word: "MXN", attribute: greenAtt)
        return startText
    }*/
    
    /*
    func getUnderline(word: String) -> NSMutableAttributedString{
        getUnderline(words: [word])
    }*/
    
    public func convertToDate(fromFormat: String, timeZone:String = "UTC") -> Date? {
        let dateFormatter = DateFormatter()
        let lc = UserDefaults.standard.string(forKey: "AppleLanguage") ?? "en"
        dateFormatter.locale = Locale(identifier: lc)
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        guard let date = dateFormatter.date(from: self) else { return nil }
        return date
    }
    
    public func convertIntoDateFormated(fromFormat: String? = "yyyy-MM-dd'T'HH:mm:ss", toFormat: String) -> String? {
        
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let lc = /*UserDefaults.standard.string(forKey: "AppleLanguage") ??*/ "es_MX"
        dateFormatter.locale = Locale(identifier: lc)
        dateFormatter.dateFormat = fromFormat
        //dateFormatter.timeZone = TimeZone(identifier: "UTC")
        guard let date = dateFormatter.date(from: self) else { return nil }
       
        dateFormatter.locale = Locale(identifier: lc)
        dateFormatter.dateFormat =  toFormat
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date).capitalized
    }

    static func emojiFlag(for countryCode: String) -> String! {
        func isLowercaseASCIIScalar(_ scalar: Unicode.Scalar) -> Bool {
            return scalar.value >= 0x61 && scalar.value <= 0x7A
        }

        func regionalIndicatorSymbol(for scalar: Unicode.Scalar) -> Unicode.Scalar {
            precondition(isLowercaseASCIIScalar(scalar))

            // 0x1F1E6 marks the start of the Regional Indicator Symbol range and corresponds to 'A'
            // 0x61 marks the start of the lowercase ASCII alphabet: 'a'
            return Unicode.Scalar(scalar.value + (0x1F1E6 - 0x61))!
        }

        let lowercasedCode = countryCode.lowercased()
        guard lowercasedCode.count == 2 else { return nil }
        guard lowercasedCode.unicodeScalars.reduce(true, { accum, scalar in accum && isLowercaseASCIIScalar(scalar) }) else { return nil }

        let indicatorSymbols = lowercasedCode.unicodeScalars.map({ regionalIndicatorSymbol(for: $0) })
        return String(indicatorSymbols.map({ Character($0) }))
    }
    
    func range(word: String) -> NSRange{
        (self as NSString).range(of: word)
    }
    
    /*func getTimeOfDay() -> Date? {
        let today = Date().convertToString(format: "yyyy-MM-dd")
        let fullDay = "\(today) \(self)"
        return fullDay.convertToDate(fromFormat: "yyyy-MM-dd HH:mm",timeZone: "America/Mexico_City")
    }*/
   
    public func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = pattern.index(pattern.startIndex, offsetBy: index)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
    
    /// Formatting text for currency textField
    public func currencyInputFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
    
        number = currencyStringToNumber()
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        return formatter.string(from: number)!
    }
    
    public func currencyStringToNumber() -> NSNumber {
        var amountWithPrefix = self
    
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
    
        let double = (amountWithPrefix as NSString).doubleValue
        return NSNumber(value: (double / 100))
    }
    
    /// Función para devolver un entero separado por comas (###,###,###).
    /// - Returns: String con el formato de separación cada 3 cifras.
    public func separateByCommas() -> String? {
        guard let double = Double(self) else {return nil}
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: double))
    }
    
    func firstWord() -> String? {
        return self.components(separatedBy: " ").first
    }
}

enum TextValidation: String,CaseIterable {
    case mail = "^([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5})$"
    case password = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,10}$"
    case digit = ".{8,16}$"
    case notEmpty = ".+"
    case upperLetter = "^(.*[A-Z].*)"
    case lowerLetter = "^(.*[a-z].*)"
    case number = "^(?=.*\\d).{10,13}"
    case integer = "[1-9][0-9]*"
    case phone = "[0-9]{2}-[0-9]{4}(-([0-9]{1,5}))?"
}

extension NSMutableAttributedString {
    public func add(word: String,attribute: [NSAttributedString.Key:Any]){
        let rangeWord = (string as NSString).range(of: word)
        addAttributes(attribute, range: rangeWord)
    }
    
   /* func makeGreen(word: String){
        let greenAtt:[NSAttributedString.Key:Any] = [.font: UIFont.openSans.semibold.of(size: 14),
                                                     .foregroundColor: UIColor.middleGreenClub]
        add(word: word, attribute: greenAtt)
    }*/
}
