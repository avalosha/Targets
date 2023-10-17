//
//  HomeViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 29/09/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var firstCollectionView: UICollectionView!
    
    private var digimonData: [Content] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        getDigimons()
    }
    
    private func setupCollectionView() {
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        HomeCell.registerCell(collectionView: firstCollectionView)
    }

    private func getDigimons() {
        let params: [String: Any] = ["page": 1]
        let res = API.makeURLRequest(end: .digimon, parameters: params)
        
        API.request(url: res) { [weak self] (data, code) in
            if code != .success {
                print("Code: ",code.rawValue," Message: ",code.message)
                self?.view.backgroundColor = .red
            }
            
            guard let response: DigimonResponse = data?.decodeData() else { return }
            dump(response)
            self?.digimonData = response.content
            self?.firstCollectionView.reloadData()
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
        print("W: ",width," H: 180")
        return CGSize(width: width, height: 220)
    }
    
}

// MARK: - DigimonResponse
struct DigimonResponse: Codable {
    let content: [Content]
    let pageable: Pageable
}

// MARK: - Content
struct Content: Codable {
    let id: Int
    let name: String
    let href: String
    let image: String
}

// MARK: - Pageable
struct Pageable: Codable {
    let currentPage, elementsOnPage, totalElements, totalPages: Int
    let previousPage: String
    let nextPage: String
}
