//
//  TestVc.swift
//  BadgesTutorial
//
//  Created by Alexander Korchak on 16.11.2023.
//

import UIKit

class TestVc: UIViewController {

    let vc = SuperVipPromoViewController()

    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return button
    }()

    @objc func startTimer() {
        present(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            startButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}

#Preview {
    TestVc()
}
