//
//  SuperVipPromoModel.swift
//  BadgesTutorial
//
//  Created by Alexander Korchak on 15.11.2023.
//

import Foundation

struct SuperVipPromoModel {
    public let mainLabelText: String
    public let descriptionLabelText: String
    public let imageName: String
    public let cashbackLabelText: String
    public let connectButtonText: String
    public let bottomButtonText: String

    public init(
        mainLabelText: String,
        descriptionLabelText: String,
        imageName: String,
        cashbackLabelText: String,
        connectButtonText: String,
        bottomButtonText: String
    ) {
        self.mainLabelText = mainLabelText
        self.descriptionLabelText = descriptionLabelText
        self.imageName = imageName
        self.cashbackLabelText = cashbackLabelText
        self.connectButtonText = connectButtonText
        self.bottomButtonText = bottomButtonText
    }
}
