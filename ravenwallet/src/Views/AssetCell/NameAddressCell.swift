//
//  DescriptionSendCell.swift
//  ravenwallet
//
//  Created by Adrian Corscadden on 2016-12-16.
//  Copyright © 2018 Ravenwallet Team. All rights reserved.
//

import UIKit

class NameAddressCell : SendCell {

    init(placeholder: String) {
        super.init()
        textField.delegate = self
        textField.textColor = .darkText
        textField.font = .customBody(size: 20.0)
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        self.placeholder.text = placeholder
        setupViews()
        setInitialData()
    }

    var didBeginEditing: (() -> Void)?
    var didReturn: ((UITextField) -> Void)?
    var didChange: ((String) -> Void)?
    var content: String? {
        didSet {
            textField.text = content
            textFieldDidChange(textField)
        }
    }

    let textField = UITextField()
    fileprivate let placeholder = UILabel(font: .customBody(size: 16.0), color: .grayTextTint)
    private func setupViews() {
        addSubview(textField)
        textField.constrain([
            textField.constraint(.leading, toView: self, constant: 11.0),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: C.padding[2]),
            textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -C.padding[2]) ])

        textField.addSubview(placeholder)
        placeholder.constrain([
            placeholder.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            placeholder.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 5.0) ])
    }
    
    private func setInitialData() {
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NameAddressCell : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        didBeginEditing?()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        placeholder.isHidden = (textField.text?.utf8.count)! > 0
        if let text = textField.text {
            didChange?(text)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didReturn?(textField)
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        didReturn?(textField)
    }
}
