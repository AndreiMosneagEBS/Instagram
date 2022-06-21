//
//  PostViewController.swift
//  Instagram
//
//  Created by Andrei Mosneag on 07.06.2022.
//

import UIKit

/*
 Section
 - Header model
 Section
 - Post cell model
 Section
 - Action button cell model
 Section
 - n Numbers of general model for comments
 */

// state of renderer cell
enum PostRenderType {
    case header(provider:User )
    case primaryContent(provider: UserPost) // post
    case action(provider: String) // likes, comments, share
    case comments(provider: [PostComment])
}
//model of render posts
struct PostRenderViewModel {
let renderType : PostRenderType
}

class PostViewController: UIViewController {
    
    private let model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
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
    
    // MARK: - Init
     
    init(model: UserPost?){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureModels(){
        guard let userPostModel = self.model else {
            return
        }
        // header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        
        //post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        
        // actions
        renderModels.append(PostRenderViewModel(renderType: .action(provider: "")))
        
        //comment
        var comments = [PostComment]()
        for x in 0..<4  {
            comments.append(PostComment(identifier: "123\(x)",
                                        username: "@daved",
                                        text: "Greean post",
                                        createdDate: Date(),
                                        likes: []
                                       )
            )
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(provider: comments)))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }


}
extension PostViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
            
        case .header(_):
            return 1
        case .primaryContent(_):
            return 1
        case .action(_):
            return 1
        case .comments(let comments): return comments.count > 4 ? 4:comments.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let model  = renderModels[indexPath.section]
        switch model.renderType {
            
        case .action(let action):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.identifier,
                                                     for: indexPath) as! IGFeedPostActionTableViewCell
            return cell
            
        case .comments(let coments ):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedGeneralTableViewCell.identifier,
                                                     for: indexPath) as! IGFeedGeneralTableViewCell
            return cell
            
        case .primaryContent(let post ):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier,
                                                     for: indexPath) as! IGFeedPostTableViewCell
            return cell
            
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,
                                                     for: indexPath) as! IGFeedPostHeaderTableViewCell
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model  = renderModels[indexPath.section]
        switch model.renderType {
        case .action(_): return 60
        case .comments(_): return 50
        case .primaryContent(_): return tableView.width
        case .header(_): return 70
            
            
            
        }
    }
}
