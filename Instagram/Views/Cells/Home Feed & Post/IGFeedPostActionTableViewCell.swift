//
//  IGFeedPostActionTableViewCell.swift
//  Instagram
//
//  Created by Andrei Mosneag on 09.06.2022.
//

import UIKit
protocol IGFeedPostActionTableViewCellDelegate: AnyObject{
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapSendButton()
}
class IGFeedPostActionTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostActionTableViewCell"
    
    weak var delegate: IGFeedPostActionTableViewCellDelegate?
     
    
    private let likeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin )
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin )
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin )
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sendButton)
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton ), for: .touchUpInside)
        commentButton .addTarget(self, action: #selector(didTapCommentButton ), for: .touchUpInside)


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @ objc private func didTapLikeButton() {
        delegate?.didTapLikeButton()
    }
    
    @ objc private func didTapCommentButton() {
        delegate?.didTapCommentButton()
    }
    
    @ objc private func didTapSendButton() {
        delegate?.didTapSendButton() 
    }
    
    
    public func configure(with post: UserPost ) {
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let sizeButton = contentView.height - 10
        let button  = [likeButton, commentButton , sendButton]
        for x in 0..<button.count {
            let button  = button[x]
            button.frame = CGRect(x: (CGFloat(x)*sizeButton)+(10*CGFloat(x)),
                                  y: 5,
                                  width: sizeButton,
                                   height: sizeButton)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    
    
}
