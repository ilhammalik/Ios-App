//
//  TermController.swift
//  Pay4date
//
//  Created by kufed-ios on 8/15/16.
//  Copyright © 2016 Ilham Malik Ibrahim. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class UploadPhotoController: UIViewController,UIImagePickerControllerDelegate   {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var views : UIView!
    @IBOutlet var submit : UIButton!
    @IBOutlet var retake : UIButton!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
        
    }
    
    @IBAction func takePhoto(sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
            imageView =  UIImageView(frame:CGRectMake(1000, 1000, 1000, 1000))
            
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}
