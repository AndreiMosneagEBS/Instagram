//
//  IGFeedPostTableViewCell.swift
//  Instagram
//
//  Created by Andrei Mosneag on 09.06.2022.
//
import AVFoundation
import SDWebImage
import UIKit
// cell for primary post
final class IGFeedPostTableViewCell: UITableViewCell {
 
    static let identifier = "IGFeedPostTableViewCell "
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var player: AVPlayer?
    private var playerLayer =  AVPlayerLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with post: UserPost ) {
        postImageView.image = UIImage(named: "test")
        return
        switch post.postType {
        case .photo:
            // show image
            postImageView.sd_setImage(with: post.postURL,completed: nil )
        case .video:
            player = AVPlayer(url: post.postURL)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        // load and play video
             
             
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image =  nil
         
    }
}
