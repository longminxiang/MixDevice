//
//  MixDevice.swift
//  MixExtention
//
//  Created by Eric Lung on 2019/2/19.
//  Copyright © 2019 Mix. All rights reserved.
//

import UIKit

@objc public class MixDevice: NSObject, Codable {

    ///品牌, Apple
    @objc public let brand: String = "Apple"

    ///模型, iPhone/iPad
    @objc public let model: String = UIDevice.current.model

    ///操作系统, iOS
    @objc public let system: String = UIDevice.current.systemName

    ///操作系统版本, "12.1"/"11.0"
    @objc public let systemVersion: String = UIDevice.current.systemVersion

    @objc public let bundleId: String = Bundle.main.bundleIdentifier ?? ""

    @objc public let appName: String = (Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? "").components(separatedBy: ".").last ?? ""

    @objc public let displayName: String = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""

    @objc public let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""

    @objc public let appBuildNum: Int = Bundle.main.infoDictionary?["CFBundleVersion"] as? Int ?? 0

    @objc public let pixelRatio: CGFloat = UIScreen.main.currentMode?.pixelAspectRatio ?? 0

    @objc public let scale: CGFloat = UIScreen.main.scale

    @objc public let screenWidth: CGFloat = UIScreen.main.bounds.size.width

    @objc public let screenHeight: CGFloat = UIScreen.main.bounds.size.height


    @objc public let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height

    @objc public let navigationBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height + 44

    @objc public let tabBarHeight: CGFloat = UIScreen.main.bounds.size.height >= 812 ? 83 : 49

    @objc public let safeAreaBottom: CGFloat = UIScreen.main.bounds.size.height >= 812 ? 34 : 0


    @objc public let iPhone4: Bool = UIScreen.main.bounds.size.height == 480

    @objc public let iPhone5: Bool = UIScreen.main.bounds.size.height == 568 && UIScreen.main.bounds.size.width == 320

    @objc public let iPhone7Plus: Bool = UIScreen.main.bounds.size.height == 736 && UIScreen.main.bounds.size.width == 414

    @objc public let iPhoneX: Bool = UIScreen.main.bounds.size.height >= 812

    @objc public let iOS11: Bool = (Int(UIDevice.current.systemVersion.components(separatedBy: ".").first ?? "") ?? 0) >= 11

    @objc public var extStringInfo: [String: String] = [:]

    @objc public var extIntInfo: [String: Int] = [:]


    @objc public class var shared: MixDevice {
        struct Singleton {
            static let instance: MixDevice = {
                return MixDevice()
            }()
        }
        return Singleton.instance
    }

    @objc public func jsonString() -> String? {
        guard let data = self.jsonData() else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }

    @objc public func jsonData() -> Data? {
        guard let data = try? JSONEncoder().encode(self),
            var dict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
        else {
            return nil
        }

        if let stringDict = dict["extStringInfo"] as? [String: String] {
            for (key, value) in stringDict {
                dict[key] = value
            }
        }
        if let intDict = dict["extIntInfo"] as? [String: Int] {
            for (key, value) in intDict {
                dict[key] = value
            }
        }
        dict.removeValue(forKey: "extStringInfo")
        dict.removeValue(forKey: "extIntInfo")
        return try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    }

    @objc public func jsonObject() -> Any? {
        guard let data = self.jsonData() else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }

    @objc public func add(key: String, string: String) {
        self.extStringInfo[key] = string
    }

    @objc public func add(key: String, intValue: Int) {
        self.extIntInfo[key] = intValue
    }
}
