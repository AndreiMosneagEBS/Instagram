//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Andrei Mosneag on 07.06.2022.
//
import SafariServices
import UIKit
struct SetingCellModell { // a
    let title: String
    let hendel: (()-> Void)
}
final class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame:.zero,
                                    style:.grouped)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SetingCellModell]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.addSubview(tableView )
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func configureModels() {
        
        
        data.append([
            SetingCellModell(title: "Edit profile") {[weak self] in
                self?.didTapEditProfile()

            },
            SetingCellModell(title: "Invite Frends") {[weak self] in
                self?.didTapInviteFriends()
            },
            SetingCellModell(title: "Save original post") {[weak self] in
                self?.didTapSaveOriginalPost()
            },
        ])
        data.append([
            SetingCellModell(title: "Terms of services") {[weak self] in
                self?.oppenURL(type: .terms)
            },
            SetingCellModell(title: "Privacy Political") {[weak self] in
                self?.oppenURL(type: .privacy)

            },
            SetingCellModell(title: "Help / Feed Back") {[weak self] in
                self?.oppenURL(type: .help)

            },
        ])
        data.append([
            SetingCellModell(title: "Log Out", hendel: {[weak self] in
                self?.didTapLogOut()
                
            })
        ])
    }
    
    enum SetingsURLType {
        case terms, privacy, help
    }
    private func oppenURL(type: SetingsURLType) {
        let urlString: String
        switch type {
        case .terms:
            urlString = "https://help.instagram.com/581066165581870"
        case .privacy:
            urlString = "https://help.instagram.com/196883487377501"
        case .help:
            urlString = "https://help.instagram.com"

        }
        guard let url = URL(string: urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc , animated: true)
    }
    
    private func didTapEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func didTapSaveOriginalPost(){
        
    }
    private func didTapInviteFriends(){
        
    }
    
    
    private func didTapLogOut(){
        let actionSheet = UIAlertController(title: "Log Out",
                                            message: "Are you sure you want to log out?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Calce",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out",
                                            style: .destructive, handler: { _ in
            
            AuthManager.shared.logOut { succes in
                DispatchQueue.main.async {
                    if succes {
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true) {
                            self.navigationController?.popViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }else{
                        
                        return
                    }
                }
            }
        }))
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet, animated: true)

    }
    
    
}
extension SettingsViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].hendel()
        // Handel cell selection
    }
}
