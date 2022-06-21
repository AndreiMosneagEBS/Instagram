//
//  UserFollowTableViewCell.swift
//  Instagram
//
//  Created by Andrei Mosneag on 14.06.2022.
//

import UIKit
protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserRelationShip)
}
enum FollowState {
    case following // indicate the current user is following the other user
    case not_following // indicate the current user is  NOT following the other user 
}
struct UserRelationShip {
    let name: String
    let username: String
    let type: FollowState
}
                                                
class UserFollowTableViewCell: UITableViewCell {

    static let identifier = "UserFollowTableViewCell"
    
     weak var delegate: UserFollowTableViewCellDelegate?
    
    private var model: UserRelationShip?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Joe"
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "@Joe"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let followerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
    }()
    
//    private let followerButton: UIButton = {
//        let button = UIButton()
//        return button
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(followerButton)
        contentView.addSubview(profileImageView)
        selectionStyle = .none

        followerButton.addTarget(self,
                                 action: #selector(didTapToFollowingButton),
                                 for: .touchUpInside)
    }
    
    @objc private func didTapToFollowingButton() {
        guard let model = model else {
            return
        }

        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with model: UserRelationShip) {
        self.model = model
        nameLabel.text = model.name
        usernameLabel.text = model.username
        switch model.type {
            
        case .following:
            // show unfollow button
            followerButton.setTitle("Unfollow", for: .normal)
            followerButton.setTitleColor(.label, for: .normal)
            followerButton.backgroundColor = .systemBackground
            followerButton.layer.borderWidth = 1
            followerButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            // show follow button
            followerButton.setTitle("Follow", for: .normal)
            followerButton.setTitleColor(.white, for: .normal)
            followerButton.backgroundColor = .systemBlue
            followerButton.layer.borderWidth = 0
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        usernameLabel.text = nil
        followerButton.setTitle(nil, for: .normal)
        followerButton.layer.borderWidth = 0
        followerButton.backgroundColor = nil
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height - 6,
                                        height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.height / 2.0
        
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width/3
        followerButton.frame = CGRect(x: contentView.width-5-buttonWidth,
                                      y: (contentView.height-40)/2,
                                      width: buttonWidth,
                                      height: 40)
        let labelHeight = contentView.height / 2
        nameLabel.frame = CGRect(x: profileImageView.right + 5,
                                 y: 0,
                                 width: contentView.width - 8 - profileImageView.width-buttonWidth,
                                 height: labelHeight)
        
        usernameLabel.frame = CGRect(x: profileImageView.right + 5,
                                     y: nameLabel.bottom,
                                 width: contentView.width - 8 - profileImageView.width-buttonWidth,
                                 height: labelHeight)
        
    }
}
