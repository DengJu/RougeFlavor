import UIKit
import CommonCrypto

extension String {
    /// 随机长度字符串
    /// - Parameter length: 长度
    /// - Returns: 描述
    static func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    /// 验证签名
    /// - Parameter key: 秘钥
    /// - Returns: 签名后的base64字符串
    func HMAC(key: String) -> String {
        guard let data = Data(base64Encoded: key, options: .ignoreUnknownCharacters), let content = (self as NSString).utf8String else { return "" }
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: Int(CC_MD5_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgMD5), data.bytes, 64, content, strlen(content), result)
        let HMACData = Data(bytes: result, count:  Int(CC_MD5_DIGEST_LENGTH)).base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        return HMACData
    }
    
    /// json字符串转字典
    /// - Returns: 字典
    func convertDictionary() -> NSDictionary? {
        let string = (self as NSString).trimmingCharacters(in: CharacterSet.controlCharacters)
        guard let jsonData: Data = string.data(using: .utf8) else { return nil }
        if let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) {
            return dict as? NSDictionary
        }
        return nil
    }
    
}

//MARK: - Dictionary
extension Dictionary {
    
    var toJsonString: String {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else { return "" }
        guard let str = String(data: data, encoding: .utf8) else { return "" }
        return str
    }
    
}

extension UIDevice {
    
    static var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case "iPhone7,1": return "iPhone 6 Plus"
        case "iPhone7,2": return "iPhone 6"
        case "iPhone8,1": return "iPhone 6s"
        case "iPhone8,2": return "iPhone 6s Plus"
        case "iPhone8,4": return "iPhone SE"
        case "iPhone9,1": return "iPhone 7"
        case "iPhone9,2": return "iPhone 7 Plus"
        case "iPhone9,3": return "iPhone 7"
        case "iPhone9,4": return "iPhone 7 Plus"
        case "iPhone10,1": return "iPhone 8"
        case "iPhone10,2": return "iPhone 8 Plus"
        case "iPhone10,3": return "iPhone X"
        case "iPhone10,4": return "iPhone 8"
        case "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,6": return "iPhone X"
        case "iPhone11,8": return "iPhone XR"
        case "iPhone11,2": return "iPhone XS"
        case "iPhone11,4": return "iPhone XS Max"
        case "iPhone11,6": return "iPhone XS Max"
        case "iPhone12,1": return "iPhone 11"
        case "iPhone12,3": return "iPhone 11 Pro"
        case "iPhone12,5": return "iPhone 11 Pro Max"
        case "iPhone13,1": return "iPhone 12 mini"
        case "iPhone13,2": return "iPhone 12"
        case "iPhone13,3": return "iPhone 12 Pro"
        case "iPhone13,4": return "iPhone 12 Pro Max"
        case "iPhone14,2": return "iPhone 13 Pro"
        case "iPhone14,3": return "iPhone 13 Pro Max"
        case "iPhone14,4": return "iPhone 13 Mini"
        case "iPhone14,5": return "iPhone 13"
        
        case "iPad13,9": return "iPad Pro 12.9 inch 5th Gen"
        case "iPad13,10": return "iPad Pro 12.9 inch 5th Gen"
        case "iPad13,11": return "iPad Pro 12.9 inch 5th Gen"
        case "iPad14,1": return "iPad mini (6th generation) Wi-Fi"
        case "iPad14,2": return "iPad mini (6th generation) Wi-Fi + Cellular"
        
        case "i386": return "Simulator"
        case "x86_64": return "Simulator"
        default: return ""
        }
    }
}
