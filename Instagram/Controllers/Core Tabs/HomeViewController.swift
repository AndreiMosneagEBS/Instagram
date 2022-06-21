//
//  ViewController.swift
//  Instagram
//
//  Created by Andrei Mosneag on 07.06.2022.
//
import FirebaseAuth
import UIKit

struct HomeFeedRendViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let action: PostRenderViewModel
    let comments: PostRenderViewModel
}


class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRendViewModel]()
 
    private let tableView:UITableView = {
        let tableView = UITableView()
        // register a cell
        tableView.register(IGFeedPostTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostActionTableViewCell.identifier)
        tableView.register(IGFeedGeneralTableViewCell.self,
                           forCellReuseIdentifier: IGFeedGeneralTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
         super.viewDidLoad()
        createMockModels()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    private func createMockModels() {
        let user = User(username: "Joe",
                        bio: "",
                        name: (first: "", last: ""),
                        profilePhoto: URL(string: "https://www.google.com/?client=safari")!,
                        birthDate: Date(),
                        gender: .Male ,
                        count: UserCount(followers: 1, following: 1, post: 1),
                        joinDate: Date())
        let post = UserPost(identifier: "",
                            postType: .photo,
                            thumbnailImage: URL(string: "https://www.google.com/")!,
                            postURL: URL(string: "https://www.google.com/")!,
                            caption: nil,
                            likeCount: [], comments: [],
                            createdDate: Date(),
                            taggedUsers: [],
                            owner: user)
        var comments = [PostComment]()
        for x in 0..<2 {
            comments.append(PostComment(identifier: "\(x)",
                                        username: "@jenny",
                                        text: "This is the best post i've seen",
                                        createdDate: Date(),
                                        likes: []))
        }
        
        for x in 0..<5 {
            let viewModels = HomeFeedRendViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                   post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                   action: PostRenderViewModel(renderType: .action(provider: "" )),
                                                   comments: PostRenderViewModel(renderType: .comments(provider: comments)))
            feedRenderModels.append(viewModels)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        hendelNoAuthentificated()
        
    }
    
    private func hendelNoAuthentificated() {
        
        if Auth.auth().currentUser == nil {
            // Show log in
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model:HomeFeedRendViewModel
        if x == 0{
            
             model = feedRenderModels[0]
            
        }else {
            let position = x % 4 == 0 ? x/4 : ((x-(x % 4))/4)
              model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        if subSection == 0 {
            // header
            return 0
        }
        else if subSection == 1 {
            // post
            return 1
        }
        else if subSection == 2 {
            // actions
            return 1
        }
        else if subSection == 3 {
            // comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments):
                return comments.count > 2 ? 2 : comments.count
            case .header, .action, .primaryContent: return 0
            }
        }
        return 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model:HomeFeedRendViewModel
        if x == 0{
            
             model = feedRenderModels[0]
            
        }else {
            let position = x % 4 == 0 ? x/4 : ((x-(x % 4))/4)
              model = feedRenderModels[position]
        }
        let subSection = x % 4
        if subSection == 0 {
            // header
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell  .identifier,
                                                         for: indexPath) as! IGFeedPostHeaderTableViewCell
                return cell
            case .comments, .action, .primaryContent: return UITableViewCell()
            }
      
        }
        else if subSection == 1 {
            // post
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell  .identifier,
                                                         for: indexPath) as! IGFeedPostTableViewCell
                cell.configure(with: post)
                return cell
            case .comments, .action, .header: return UITableViewCell()
            }
        }
        else if subSection == 2 {
            // actions
            switch model.action.renderType {
            case .action(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostActionTableViewCell
                cell.delegate = self
                return cell
            case .comments, .header, .primaryContent: return UITableViewCell()
            }
        }
        else if subSection == 3 {
            // comments
            
            switch model.comments.renderType {
            case .comments(let comment):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedGeneralTableViewCell  .identifier,
                                                         for: indexPath) as! IGFeedGeneralTableViewCell
                return cell
            case .header, .action, .primaryContent: return UITableViewCell()
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let subSection = indexPath.section % 4
        if subSection == 0 {
            return 70
            // header
        }
        else if subSection == 1{
            return tableView.width
            //post
        }
        else if subSection == 2 {
            return 60
            // action
        }
        else if subSection == 3{
            return 50
            // Comment row 
        }
        return 0
    }
}
extension HomeViewController : IGFeedPostActionTableViewCellDelegate {
    func didTapLikeButton() {
        print("Like ")
    }
    
    func didTapCommentButton() {
        print("COMEMNT ")

    }
    
    func didTapSendButton() {
        print("SEND ")

    }
    
    
}
