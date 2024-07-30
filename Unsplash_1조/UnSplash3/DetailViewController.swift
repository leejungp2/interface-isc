//
//  DetailViewController.swift
//  PhotoSearch
//
//  Created by 쩡이 on 2021/12/14.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    var detailImageUrl: String?

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.setTitle("", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let detailImageUrl = detailImageUrl {
            let url = URL(string: detailImageUrl)!
            detailImageView.kf.setImage(with: url)
        }
    }
    
    @IBAction func closeButtonclicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
