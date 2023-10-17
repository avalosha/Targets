//
//  CustomImageView.swift
//  Targets
//
//  Created by Sferea-Lider on 17/10/23.
//

import UIKit

protocol CustomImageViewDelegate: NSObjectProtocol {
    func onImageSucces()
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {

    var currentImage = #imageLiteral(resourceName: "logo_digimon")
    var imageURLString: String?
    weak var delegate : CustomImageViewDelegate? = nil
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable
    var enableTint: Bool = false {
        didSet {
            image = image?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpView()
    }
    
    public func setUpView() {
        layer.cornerRadius = cornerRadius < 0 ? bounds.height/2 : cornerRadius
    }
    
    public func download(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        download(from: url, contentMode: mode)
    }
    
    private func download(from url: URL?, contentMode mode: ContentMode = .scaleAspectFit, retries: Int = 3, authorization: Bool = true) {
        
        image = currentImage
        contentMode = .scaleAspectFit
        
        guard let url = url else { return }
        imageURLString = url.absoluteString
        if let cachedImg = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.contentMode = mode
            loadFade(cachedImg)
        }
        
        let urlRequest = API.makeURLRequest(url: url)
        
        API.request(url: urlRequest) { [weak self] data, error in
            guard error == .success, let info = data, let img = UIImage(data: info) else {
                if retries > 0 {
                    DispatchQueue.main.async {
                        self?.download(from: url, retries: -1)
                    }
                }
                return
            }
            
            DispatchQueue.main.async {
                if self?.imageURLString == url.absoluteString {
                    self?.contentMode = mode
                    self?.loadFade(img)
                }
                
                imageCache.setObject(img, forKey: url as AnyObject)
            }
        }
    }
    
    func loadFade(_ image: UIImage) {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.image = image
            self.delegate?.onImageSucces()
        }, completion: nil)
    }

}
