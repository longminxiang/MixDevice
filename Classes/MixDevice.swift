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
    ///bundle id
    @objc public let bundleId: String = Bundle.main.bundleIdentifier ?? ""
    ///app name
    @objc public let appName: String = (Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? "").components(separatedBy: ".").last ?? ""
    ///disply name
    @objc public let displayName: String = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    ///version
    @objc public let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    ///build number
    @objc public let appBuildNum: Int = Bundle.main.infoDictionary?["CFBundleVersion"] as? Int ?? 0
    ///pixel ratio
    @objc public let pixelRatio: CGFloat = UIScreen.main.currentMode?.pixelAspectRatio ?? 0
    ///scale 2.0/3.0
    @objc public let scale: CGFloat = UIScreen.main.scale
    ///screen width
    @objc public let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    ///screen height
    @objc public let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    ///statusBar height
    @objc public let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
    ///navigationBar height
    @objc public let navigationBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height + 44
    ///tabBar height
    @objc public let tabBarHeight: CGFloat = UIScreen.main.bounds.size.height >= 812 ? 83 : 49
    ///safe area bottom height
    @objc public let safeAreaBottom: CGFloat = UIScreen.main.bounds.size.height >= 812 ? 34 : 0
    ///is iphone4
    @objc public let iPhone4: Bool = UIScreen.main.bounds.size.height == 480
    ///is iphone5
    @objc public let iPhone5: Bool = UIScreen.main.bounds.size.height == 568 && UIScreen.main.bounds.size.width == 320
    ///is iphone7 plus
    @objc public let iPhone7Plus: Bool = UIScreen.main.bounds.size.height == 736 && UIScreen.main.bounds.size.width == 414
    ///is iphoneX
    @objc public let iPhoneX: Bool = UIScreen.main.bounds.size.height >= 812
    ///is ios11
    @objc public let iOS11: Bool = (Int(UIDevice.current.systemVersion.components(separatedBy: ".").first ?? "") ?? 0) >= 11
    ///extionsion info
    @objc private var extInfo: [String: Any] = [:]

    @objc public class var shared: MixDevice {
        struct Singleton {
            static let instance: MixDevice = {
                return MixDevice()
            }()
        }
        return Singleton.instance
    }

    enum CodingKeys: String, CodingKey {
        case brand
        case model
        case system
        case systemVersion
        case bundleId
        case appName
        case displayName
        case appVersion
        case appBuildNum
        case pixelRatio
        case scale
        case screenWidth
        case screenHeight
        case statusBarHeight
        case navigationBarHeight
        case tabBarHeight
        case safeAreaBottom
        case iPhone4
        case iPhone5
        case iPhone7Plus
        case iPhoneX
        case iOS11
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
        self.extInfo.forEach {key, value in
            dict[key] = value
        }
        return try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    }

    @objc public func jsonObject() -> Any? {
        guard let data = self.jsonData() else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }

    @objc public func add(_ key: String, _ value: Any) {
        self.extInfo[key] = value
    }
}
