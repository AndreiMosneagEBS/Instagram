//
//  ProfileITabsCollectionReusableView.swift
//  Instagram
//
//  Created by Andrei Mosneag on 10.06.2022.
//

import UIKit

class ProfileITabsCollectionReusableView: UICollectionReusableView {
        static let identifier = "ProfileITabsCollectionReusableView"
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
