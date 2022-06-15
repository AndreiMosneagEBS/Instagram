//
//  ProfileITabsCollectionReusableView.swift
//  Instagram
//
//  Created by Andrei Mosneag on 10.06.2022.
//

import UIKit
protocol ProfileITabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButtonTab()
    func didTapTaggedButtonTab()

}

class ProfileITabsCollectionReusableView: UICollectionReusableView {
        static let identifier = "ProfileITabsCollectionReusableView"
    
    public weak var delegate: ProfileITabsCollectionReusableViewDelegate?
    
    struct Constats {
        static let padding: CGFloat = 8
        
    }
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(taggedButton)
        addSubview(gridButton)
        
        gridButton.addTarget(self,
                             action: #selector(didTapGridButton),
                             for: .touchUpInside)
        taggedButton.addTarget(self,
                               action: #selector(didTapTaggedButton),
                               for: .touchUpInside)
        

    }
    
    @objc private func didTapGridButton(){
        gridButton.tintColor  = .systemBlue
        taggedButton.tintColor = .lightGray
        delegate?.didTapGridButtonTab()
    }
    
    @objc private func didTapTaggedButton(){
        gridButton.tintColor  = .lightGray
        taggedButton.tintColor = .systemBlue
        delegate?.didTapTaggedButtonTab()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height-(Constats.padding * 2)
        let gridButtonX = ((width/2)-size)/2
        gridButton.frame = CGRect(x: gridButtonX,
                                  y: Constats.padding,
                                    width: size,
                                    height: size)
        taggedButton.frame = CGRect(x: gridButtonX + (width/2),
                                    y: Constats.padding,
                                    width: size,
                                    height: size)
    }
}
