//
//  HomeCell.swift
//  Targets
//
//  Created by Sferea-Lider on 16/10/23.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImgView: CustomImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var secondImgView: UIImageView!
    
    static let identifierCell = "HomeCell"
    static let nibName = "HomeCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func registerCell(collectionView: UICollectionView) {
        let nib = UINib(nibName: HomeCell.nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: HomeCell.identifierCell)
    }
    
    public func setupCell(with data: Content) {
        titleLbl.text = data.name
        mainImgView.download(from: data.image ?? "", contentMode: .scaleAspectFill)
    }

}
