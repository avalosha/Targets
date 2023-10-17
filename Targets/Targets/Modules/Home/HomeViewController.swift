//
//  HomeViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 29/09/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var firstCollectionView: UICollectionView!
    
    @IBOutlet weak var heightContainerOne: NSLayoutConstraint!
    
    private let viewModel = HomeViewModel()
    private var digimonData: [Content] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupBindings()
        
        viewModel.getDigimons()
    }
    
    private func setupCollectionView() {
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        HomeCell.registerCell(collectionView: firstCollectionView)
    }
    
    private func setupBindings() {
        viewModel.statusCode.bind { [weak self] code in
            print("ErrorCode: ",code.rawValue)
        }
        
        viewModel.digimonResponse.bind { [weak self] response in
            if let data = response.content {
                self?.digimonData.append(contentsOf: data)
                self?.firstCollectionView.reloadData()
            }
        }
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return digimonData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifierCell, for: indexPath) as! HomeCell
        let data = digimonData[indexPath.item]
        cell.setupCell(with: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.firstCollectionView.frame.size.width - CGFloat(1 * 10)) / CGFloat(2)
        return CGSize(width: width, height: 160)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let height = self.firstCollectionView.collectionViewLayout.collectionViewContentSize.height
        if height > 0 {
            self.heightContainerOne.constant = self.firstCollectionView.collectionViewLayout.collectionViewContentSize.height + 44
        }
    }
    
}
