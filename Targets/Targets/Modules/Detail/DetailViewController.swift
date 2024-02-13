//
//  DetailViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 13/02/24.
//

import UIKit

//--------------------------------------------------------------------------
//MARK: - New Instance
//--------------------------------------------------------------------------
extension DetailViewController {
    /// Retorna una nueva instancia de la clase DetailViewController
    /// - Returns: Instancia de DetailViewController
    static func newInstance(_ id: Int) -> DetailViewController? {
        let storyboard = UIStoryboard(name: "detail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController
        vc?.id = id
        return vc
    }
}

class DetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var mainCustomImg: CustomImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    // MARK: - Propiedades
    private let viewModel = DetailViewModel()
    private var id = 0
    
    // MARK: - Ciclo de Vida
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        viewModel.getItem(with: id)
    }
    
    // MARK: - Setup
    private func setupBindings() {
        viewModel.statusCode.bind { [weak self] code in
            print("ErrorCode: ",code.rawValue)
        }
        
        viewModel.item.bind { [weak self] res in
            self?.loadData()
        }
    }
    
    // MARK: - Funciones
    private func loadData() {
        let item = viewModel.item.value
        titleLbl.text = item.name
        mainCustomImg.download(from: item.images?.first?.href ?? "", contentMode: .scaleAspectFit)
    }
    
    // MARK: - IBActions
    
    
}
