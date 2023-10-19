//
//  ListCell.swift
//  Targets
//
//  Created by Sferea-Lider on 17/10/23.
//

import UIKit

class ListCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var customImgView: CustomImageView!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    
    static let identifierCell = "ListCell"
    static let nibName = "ListCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func registerCell(collectionView: UICollectionView) {
        let nib = UINib(nibName: ListCell.nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ListCell.identifierCell)
    }
    
    public func setupCell(with data: Content) {
        idLbl.text = "\(data.id ?? 0)"
        nameLbl.text = data.name
        typeLbl.text = ""
        customImgView.download(from: data.image ?? "", contentMode: .scaleAspectFit)
    }

}
