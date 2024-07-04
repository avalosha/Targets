//
//  DynamicCell.swift
//  Targets
//
//  Created by Sferea-Lider on 03/07/24.
//

import UIKit

class DynamicCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    private var sizeFontTitle = 14
    private var sizeFontDescription = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setupCell(with data: DataObject, size: Int? = nil) {
        titleLbl.text = data.title
        descriptionLbl.text = data.subtitle
        
        if let value = size {
            updateSizeFont(with: value)
        }
    }
    
    private func updateSizeFont(with value: Int) {
        sizeFontTitle = sizeFontTitle + value
        sizeFontDescription = sizeFontDescription + value
        titleLbl.font = UIFont.boldSystemFont(ofSize: CGFloat(sizeFontTitle))
        descriptionLbl.font = UIFont.systemFont(ofSize: CGFloat(sizeFontDescription))
    }
}
