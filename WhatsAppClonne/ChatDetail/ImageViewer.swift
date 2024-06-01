//
//  ImageViewer.swift
//  WhatsAppClonne
//
//  Created by Jhansi Ch on 01/06/24.
//

import UIKit

protocol ImageViewerDelegate: AnyObject {
    func didSelectImage(_ image: UIImage)
}

class ImageViewer: UIViewController {
    
    @IBOutlet weak var imageSelected: UIImageView!
    @IBOutlet weak var sendBtn: UIButton!
    var selectedImage: UIImage?
    weak var delegate: ImageViewerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSelected.image = selectedImage
        sendBtn.layer.cornerRadius = 24
        // Do any additional setup after loading the view.
    }
    
    @IBAction func displayImageClicked(_ sender: Any) {
        if let selectedImage = selectedImage {
            delegate?.didSelectImage(selectedImage)
        }
        dismiss(animated: true)
    }
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
