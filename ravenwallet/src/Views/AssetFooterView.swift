//
//  AccountFooterView.swift
//  ravenwallet
//
//  Created by Adrian Corscadden on 2016-11-16.
//  Copyright © 2018 Ravenwallet Team. All rights reserved.
//

import UIKit

class AssetFooterView: UIView, Subscriber, Trackable {

    var sendCallback: (() -> Void)?
    var receiveCallback: (() -> Void)?
    var buyCallback: (() -> Void)?
    
    private var hasSetup = false
    private let asset: Asset
    private let toolbar = UIToolbar()
    
    init(asset: Asset) {
        self.asset = asset
        super.init(frame: .zero)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard !hasSetup else { return }
        setup()
        hasSetup = true
    }

    private func setup() {
        let separator = UIView(color: .separatorGray)
        addSubview(toolbar)
        addSubview(separator)
        
        toolbar.clipsToBounds = true // to remove separator line
        toolbar.isOpaque = true
        
        // constraints
        toolbar.constrain(toSuperviewEdges: nil)
        separator.constrainTopCorners(height: 0.5)
        
        setupToolbarButtons()
        
        /*Store.subscribe(self, name: .didUpdateFeatureFlags) { [weak self] _ in
            self?.setupToolbarButtons()
        }*/
    }
    
    private func setupToolbarButtons() {
        // buttons
        var buttonCount: Int
        
        let send = UIButton.rounded(title: S.Button.send)
        send.tintColor = .white
        send.backgroundColor = UIColor.assetGradientStart(isOwnerShip: asset.isOwnerShip)
        send.addTarget(self, action: #selector(AssetFooterView.send), for: .touchUpInside)
        let sendButton = UIBarButtonItem(customView: send)

        let receive = UIButton.rounded(title: S.Button.receive)
        receive.tintColor = .white
        receive.backgroundColor = UIColor.assetGradientStart(isOwnerShip: asset.isOwnerShip)
        receive.addTarget(self, action: #selector(AssetFooterView.receive), for: .touchUpInside)
        let receiveButton = UIBarButtonItem(customView: receive)
        
        let paddingWidth = C.padding[2]
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
            toolbar.items = [
                flexibleSpace,
                sendButton,
                flexibleSpace,
                receiveButton,
                flexibleSpace,
            ]
            buttonCount = 2
        
        let buttonWidth = (self.bounds.width - (paddingWidth * CGFloat(buttonCount+1))) / CGFloat(buttonCount)
        let buttonHeight = CGFloat(44.0)
        [sendButton, receiveButton].forEach {
            $0.customView?.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
        }
    }

    @objc private func send() { sendCallback?() }
    @objc private func receive() { receiveCallback?() }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}
