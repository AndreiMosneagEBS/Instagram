//
//  IGFeedGeneralTableViewCell.swift
//  Instagram
//
//  Created by Andrei Mosneag on 09.06.2022.
//

import UIKit
// coments 
class IGFeedGeneralTableViewCell: UITableViewCell {

    static let identifier = "IGFeedGeneralTableViewCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemOrange

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure() {
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}
