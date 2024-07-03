//
//  DynamicTableViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 03/07/24.
//

import UIKit

class DynamicTableViewController: UIViewController {

    @IBOutlet weak var dynamicTableView: UITableView!
    @IBOutlet weak var sizeFontSlider: UISlider!
    
    private let data : [DataObject] = [
        DataObject(title: "Please Show Appreciation",
                   subtitle: "Drop a couple claps if you like this"),
        DataObject(title: "Why does Appreciation matter?",
                   subtitle: "It motivates me to keep creating content, and helps improve the reach of the article. It also lets me know wether the quality of the content is decent or not"),
        DataObject(title: "Why am I writing this article?",
                   subtitle: "Right now as of 28th Aug,2021 i dont see any article or stackoverflow answering the question about making the UIlabels dynamically resize programatically. The issue is that we can easily do this with XiB, but the same implementation programatically is not giving the desired affect and the cells wont resize."),
        DataObject(title: "Is there any other way to do this if I dont wannt use a container view",
                   subtitle: "I think there is another way to do this by calculating the number of lines you require and deciding the height appropriately."),
        DataObject(title: "What is the advantage of this method?",
                   subtitle: "Quite a few of the folks complain that they cant use numberOfLines property in UILabel inside a TableViewCell but this shall allow you to do that.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Entro")
    }
    
    private func setupTableView() {
        dynamicTableView.delegate = self
        dynamicTableView.dataSource = self
        dynamicTableView.separatorStyle = .none
        dynamicTableView.estimatedRowHeight = UITableView.automaticDimension
        // Register TableView Cell
        dynamicTableView.register(DynamicCell.nib, forCellReuseIdentifier: DynamicCell.identifier)

        // Update TableView with the data
        dynamicTableView.reloadData()
    }

    @IBAction func onChangeValueSlider(_ sender: UISlider) {
        
    }
}

extension DynamicTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DynamicCell.identifier, for: indexPath) as? DynamicCell else { fatalError("xib doesn't exist") }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
    
}

struct DataObject {
    let title: String
    let subtitle: String
}
