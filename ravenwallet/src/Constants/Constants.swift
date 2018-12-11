//
//  Constants.swift
//  ravenwallet
//
//  Created by Adrian Corscadden on 2016-10-24.
//  Copyright © 2018 Ravenwallet Team. All rights reserved.
//

import UIKit

let π: CGFloat = .pi

struct Padding {
    subscript(multiplier: Int) -> CGFloat {
        get {
            return CGFloat(multiplier) * 8.0
        }
    }
}

struct C {
    static let padding = Padding()
    struct Sizes {
        static let buttonHeight: CGFloat = 48.0
        static let headerHeight: CGFloat = 48.0
        static let largeHeaderHeight: CGFloat = 220.0
        static let logoAspectRatio: CGFloat = 125.0/417.0
        static let roundedCornerRadius: CGFloat = 6.0
    }
    static var defaultTintColor: UIColor = {
        return UIView().tintColor
    }()
    static let animationDuration: TimeInterval = 0.3
    static let secondsInDay: TimeInterval = 86400
    static let maxMoney: UInt64 = 21000000000*100000000
    static let maxAsset: UInt64 = 21000000000*100000000
    static let satoshis: UInt64 = 100000000
    // TODO Ravenize
    static let walletQueue = "com.breadwallet.walletqueue"
    static let rvnCurrencyCode = "RVN"
    static let null = "(null)"
    static let maxMemoLength = 250
    static let feedbackEmail = "feedback@breadapp.com"
    static let iosEmail = "ios@breadapp.com"
    static let reviewLink = "https://itunes.apple.com/app/breadwallet-bitcoin-wallet/id885251393?action=write-review"
    static var standardPort: Int {
        return E.isTestnet ? 18767 : 8767
    }
    static let feeCacheTimeout: TimeInterval = C.secondsInDay*3
    static let bCashForkBlockHeight: UInt32 = E.isTestnet ? 1155876 : 478559
    static let bCashForkTimeStamp: TimeInterval = E.isTestnet ? (1501597117 - NSTimeIntervalSince1970) : (1501568580 - NSTimeIntervalSince1970)
    static let txUnconfirmedHeight = Int32.max
    static var logFilePath: URL {
        let cachesDirectory = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        return URL(fileURLWithPath: cachesDirectory).appendingPathComponent("log.txt")
    }
    
    //Asset Fee
    static let creatAssetFee = UInt64(Int(500) * 100000000)
    static let manageAssetFee = UInt64(Int(100) * 100000000)

}
