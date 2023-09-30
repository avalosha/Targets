//
//  SideMenuViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 29/09/23.
//

import UIKit

protocol SideMenuViewControllerDelegate: NSObjectProtocol {
    func selectedCell(_ option: MenuOptions)
}

class SideMenuViewController: UIViewController {

    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var footerLbl: UILabel!
    
    var defaultHighlightedCell: Int = 0
    var menu: [SideMenuModel] = [
        SideMenuModel(icon: UIImage(systemName: "house.fill")!, title: "Home"),
        SideMenuModel(icon: UIImage(systemName: "music.note")!, title: "Music"),
        SideMenuModel(icon: UIImage(systemName: "film.fill")!, title: "Movies"),
        SideMenuModel(icon: UIImage(systemName: "book.fill")!, title: "Books"),
        SideMenuModel(icon: UIImage(systemName: "person.fill")!, title: "Profile"),
        SideMenuModel(icon: UIImage(systemName: "slider.horizontal.3")!, title: "Settings"),
        SideMenuModel(icon: UIImage(systemName: "hand.thumbsup.fill")!, title: "Like us on facebook")
    ]
    
    weak var delegate: SideMenuViewControllerDelegate? = nil
    
    var selectedIndex = 0
    var menuItems: [MenuOptions] = MenuOptions.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    private func setupTableView() {
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
        sideMenuTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        sideMenuTableView.separatorStyle = .none
        
        // Set Highlighted Cell
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }
        
        // Footer
        footerLbl.textColor = UIColor.white
        footerLbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        footerLbl.text = "Developed by Álvaro Ávalos"
        
        // Register TableView Cell
        self.sideMenuTableView.register(SideMenuCell.nib, forCellReuseIdentifier: SideMenuCell.identifier)

        // Update TableView with the data
        self.sideMenuTableView.reloadData()
    }

}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as? SideMenuCell else { fatalError("xib doesn't exist") }

        cell.iconImg.image = self.menu[indexPath.row].icon
        cell.titleLbl.text = self.menu[indexPath.row].title

        // Highlighted color
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = #colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)
        cell.selectedBackgroundView = myCustomSelectionColorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        delegate?.selectedCell(menuItems[selectedIndex])
    }
}

enum MenuOptions: String, CaseIterable {
    case home = "Home"
    case music = "Music"
    case film = "Film"
    case book = "Book"
    case person = "Person"
    case settings = "Settings"
    case facebook = "Facebook"
    
    var storyboard: String{
        get {
            switch self {
            case .home:
                return "home"
            case .music:
                return "home"
            case .film:
                return "home"
            case .book:
                return "home"
            case .person:
                return "home"
            case .settings:
                return "home"
            case .facebook:
                return "home"
            }
        }
    }
    
    var storyId: String{
        get {
            switch self {
            case .home:
                return "HomeNavID"
            case .music:
                return "HomeNavID"
            case .film:
                return "HomeNavID"
            case .book:
                return "HomeNavID"
            case .person:
                return "HomeNavID"
            case .settings:
                return "HomeNavID"
            case .facebook:
                return "HomeNavID"
            }
        }
    }
}
