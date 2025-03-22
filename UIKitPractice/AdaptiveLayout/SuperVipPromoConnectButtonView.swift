//
//  SuperVipPromoConnectButtonView.swift
//  UIKitPractice
//
//  Created by Kristina Grebneva on 21.03.2025.
//

import UIKit

protocol SuperViewPromoDelegate: AnyObject {
    func connectButtonStateUpdate()
}

class SuperVipPromoConnectButtonView: UIView {
    weak var delegate: SuperViewPromoDelegate?
    
    @Autolayout private var connectButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 24
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(connectButton)
        NSLayoutConstraint.activate([
            connectButton.topAnchor.constraint(equalTo: topAnchor),
            connectButton.leftAnchor.constraint(equalTo: leftAnchor),
            connectButton.rightAnchor.constraint(equalTo: rightAnchor),
            connectButton.bottomAnchor.constraint(equalTo: bottomAnchor)])
        connectButton.addTarget(self, action: #selector(connectButtonTapped), for: .touchUpInside)
    }
    
    @objc func connectButtonTapped() {
        delegate?.connectButtonStateUpdate()
    }
    
    func setTitle(_ title: String?) {
        connectButton.setTitle(title, for: .normal)
    }

}
