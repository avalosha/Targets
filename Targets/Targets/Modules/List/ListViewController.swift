//
//  ListViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 17/10/23.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var listCollectionView: UICollectionView!
    
    private let viewModel = ListViewModel()
    private var data: [Content] = []
    private var isLoading = false
    
    public var fromHome = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupBindings()
        setupView()
        
        viewModel.getDigimons()
    }
    
    private func setupCollectionView() {
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        ListCell.registerCell(collectionView: listCollectionView)
    }
    
    private func setupBindings() {
        viewModel.statusCode.bind { [weak self] code in
            print("ErrorCode: ",code.rawValue)
        }
        
        viewModel.digimonResponse.bind { [weak self] response in
            if let data = response.content {
                self?.data.append(contentsOf: data)
                self?.listCollectionView.reloadData()
                self?.isLoading = false
            }
        }
    }
    
    /// Método para configurar la vista.
    private func setupView() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        //Botones del navigation
        let menuBtn = UIButton(type: .custom)
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        
        var currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 37)
        currWidth?.isActive = true
        var currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 37)
        menuBtn.addTarget(self, action: #selector(leftMenuItemSelected), for: UIControl.Event.touchUpInside)
        
        if fromHome == false {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
            //Cambiar el icono al de Menú
            menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
            menuBtn.setImage(UIImage(named:"menu_icon"), for: .normal)
            
            currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 29)
            currWidth?.isActive = true
            currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
            
            currHeight?.isActive = true
            
            menuBtn.addTarget(revealViewController(), action: #selector(revealViewController()?.revealSideMenu), for: UIControl.Event.touchUpInside)
            
            self.navigationItem.rightBarButtonItem = menuBarItem
        } else {
            // Poner el icono de back
            menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
            menuBtn.setImage(UIImage(named:"header_back_vector"), for: .normal)
            
            currHeight?.isActive = true
        }
        
        self.navigationItem.leftBarButtonItem = menuBarItem
        
        //Permitir gesto de back
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    @objc private func leftMenuItemSelected() {
        if fromHome {
            
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func openDetail(with index: Int) {
        
    }

}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.identifierCell, for: indexPath) as! ListCell
        let data = data[indexPath.item]
        cell.setupCell(with: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.listCollectionView.frame.size.width
        return CGSize(width: width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openDetail(with: indexPath.item)
    }
    
}

extension ListViewController: UIScrollViewDelegate {
    
    /// Función para el consumo del contenido infinito.
    /// - Parameter scrollView: Contenido Infinito
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            //scrolling down
            let paddingEndScreen : CGFloat = self.view.frame.size.height * 0.45
            let offsetY = scrollView.contentOffset.y + paddingEndScreen
            let contentHeight = scrollView.contentSize.height
            let containerViewSize = scrollView.frame.height
            
            if offsetY > contentHeight - containerViewSize {
                scrollEndScreenDetected()
            }
        } else {
            //scrolling up
        }
        
        if scrollView.contentOffset.y <= 100 {
            scrollView.bounces = true
        } else {
            scrollView.bounces = false
        }
        
    }
    
    /// Detecta cuando llego al final del scroll para pedir más datos
    func scrollEndScreenDetected (){
        guard !isLoading else { return }
        isLoading = true
        viewModel.getDigimons()
    }
}

extension ListViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
