//
//  ImageDetailViewController.swift
//  SharkFeed
//
//  Created by Raxit Cholera on 2/13/18.
//  Copyright © 2018 Raxit Cholera. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var mainImageView: UIImageView!
    
    var selectedImage:Image!
    private var leftBarButton: UIBarButtonItem!
    private var rightBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(data: selectedImage.image_t! as Data)
        mainImageView.image = image
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func downloadButtonPressed(_ sender: Any) {
    }
    @IBAction func openInFlickerButtonPressed(_ sender: Any) {
    }
    

}
