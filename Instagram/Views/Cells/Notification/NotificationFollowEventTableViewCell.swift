//
//  NotificationFollowEventTableViewCell.swift
//  Instagram
//
//  Created by Andrei Mosneag on 15.06.2022.
//

import UIKit
protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    
static let identifier = "NotificationFollowEventTableViewCell"
    
     weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()
    
    private let label: UILabel =  {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines  = 0
        label.text = "@kenyWest followed you"
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        followButton.addTarget(self,
                               action: #selector(didTapFollowersButton),
                               for: .touchUpInside)
        configureForFollowing()
        selectionStyle = .none
    }
    
    @objc private func didTapFollowersButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(model: model)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
            
        case .like(let post):
            break
        case .follow(let state):
            // configure button
            switch state {
            case .following:
                // show unfollow button
                configureForFollowing()
            case .not_following:
                // show follow button
                configureForUnfollowing()
            }
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    private func configureForFollowing(){
        followButton.setTitle("Unfollow ", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private func configureForUnfollowing() {
        followButton.setTitle("Follow ", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = .link
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth  = 0
        label.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height - 6,
                                        height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        let size: CGFloat = 100
        let buttonHeight: CGFloat =  40
        followButton.frame = CGRect(x: contentView.width-5-size,
                                    y: (contentView.height - buttonHeight)/2,
                                    width: size,
                                    height: buttonHeight)
        
        label.frame = CGRect(x: profileImageView.right + 5,
                             y: 0,
                             width: contentView.width-size-profileImageView.width - 16,
                             height: contentView.height)
        
    }

}