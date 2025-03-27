//
//  ViewController.swift
//  UIKitPractice
//
//  Created by Alexander Korchak on 30.11.2023.
//

import UIKit

class EqualSquaresViewController: UIViewController {
    private enum Constants {
        static let colors: [UIColor] = [.red, .blue, .orange, .green]
        static let squareSide: CGFloat = 150
        static let padding: CGFloat = 3
    }
    
    @Autolayout private var containerView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(containerView)
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 2*Constants.squareSide + 4*Constants.padding),
            containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        for index in 0..<4 {
            let squareView = UIView()
            squareView.translatesAutoresizingMaskIntoConstraints = false
            squareView.backgroundColor = Constants.colors[index]
            containerView.addSubview(squareView)
            
            let row = index / 2
            let column = index % 2
            
            NSLayoutConstraint.activate([
                squareView.widthAnchor.constraint(equalToConstant: Constants.squareSide),
                squareView.heightAnchor.constraint(equalTo: squareView.widthAnchor),
                squareView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.padding + CGFloat(row) * (Constants.squareSide + 2*Constants.padding)),
                squareView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Constants.padding + CGFloat(column) * (Constants.squareSide + 2*Constants.padding))
            ])
        }
    }
}

#Preview {
    EqualSquaresViewController()
}

