//
//  ProductViewController.swift
//  ProductHunt
//
//  Created by Maria Semakova on 12/9/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var screenshotImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var upvotesCountLabel: UILabel!
    
    @IBOutlet weak var getItButton: UIButton!
    
    var product : ProductModel? = nil
    
    let screenshotSize = CGSize(width: 1480, height: 1037)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupProductUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    
    @IBAction func getItButtonPressed(_ sender: UIButton) {
        if let url = product?.productUrl {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        imageScrollView.delegate = self
        getItButton.layer.masksToBounds = true
        getItButton.layer.cornerRadius = 10
        getItButton.backgroundColor = UIColor(red: 128/255, green: 223/255, blue: 255/255, alpha: 1.0)
        getItButton.layer.borderWidth = 1
        getItButton.layer.borderColor = UIColor .blue.cgColor
    }
    
    private func setupProductUI() {
        
        DispatchQueue.main.async {
        
            self.screenshotImageView.kf.setImage(with: self.product?.screenshotUrl, placeholder: nil, options: [.forceRefresh, .forceTransition], progressBlock: nil, completionHandler: {(_, _, _, _) -> () in
                DispatchQueue.main.async{
                self.activityIndicator.stopAnimating()
                }
            })
            self.screenshotImageView.contentMode = .scaleToFill
            
            self.nameLabel.text = self.product?.name
            self.descriptionLabel.text = self.product?.description
            self.upvotesCountLabel.text = "▲ \(self.product?.upvotesCount ?? 0)"
            
            self.setZoomScale()
        }
        
    }
    
    private func setZoomScale() {
        let imageViewSize = screenshotSize
        let scrollViewSize = imageScrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        let minZoomScale = min(widthScale, heightScale)
        imageScrollView.minimumZoomScale = minZoomScale
        imageScrollView.setZoomScale(minZoomScale, animated: true)
    }
    
    

}

extension ProductViewController : UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return screenshotImageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        return
    }
}
