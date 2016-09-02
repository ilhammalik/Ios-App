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

<<<<<<< HEAD
class UploadPhotoController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate   {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var views : UIView!
    @IBOutlet var take : UIButton!
    @IBOutlet var submit : UIButton!
    @IBOutlet var retake : UIButton!
=======
class UploadPhotoController: UIViewController,UIImagePickerControllerDelegate   {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var views : UIView!
    @IBOutlet var submit : UIButton!
    @IBOutlet var retake : UIButton!
    
>>>>>>> origin/dev
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

<<<<<<< HEAD
        retake.hidden = true
        self.views.layer.cornerRadius = self.views.frame.height/2
        self.imageView.layer.cornerRadius = self.imageView.frame.height/2
 
=======
   
>>>>>>> origin/dev
        
    }
    
    @IBAction func takePhoto(sender: UIButton) {
<<<<<<< HEAD

        
        imagePicker =  UIImagePickerController()
        imagePicker.sourceType = .Camera
        imagePicker.cameraDevice = .Front
        imagePicker.delegate = self
=======
        imagePicker =  UIImagePickerController()
        imagePicker.sourceType = .Camera
>>>>>>> origin/dev
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
<<<<<<< HEAD
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.take.hidden = true
        self.retake.hidden = false
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        print(imageView.image)
    }

    @IBAction func sendPhoto(sender: UIButton) {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let Key = prefs.valueForKey("key") as? String
        

        let headersToken = [
            "appid": "4201620",
            "secretkey": SecretKey,
            "cache-control": CacheControl,
            "content-type": ContentType,
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json",
            "RegKey":String(Key!),
            ]
        let image = imageView.image
        
        Alamofire.upload(.POST, ApiUploadPhoto, headers: headersToken,multipartFormData: {
            multipartFormData in
            
            if let imageData = UIImageJPEGRepresentation(image!, 0.6) {
                multipartFormData.appendBodyPart(data: imageData, name: "image", fileName: "file.png", mimeType: "image/png")
            }
            
            }, encodingCompletion: {
                encodingResult in
                
                switch encodingResult {
                case .Success(let upload, _, _):
                    print("s")
                    upload.responseJSON {
                        response in
                        if let JSON = response.result.value {
                            print("JSON: \(JSON)")
                        }
                        let vc = LoginController(nibName: "Login", bundle: nil)
                        var navb = UINavigationController(rootViewController: vc)
                        self.presentViewController(navb, animated:true, completion:nil)
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Upload Success"
                        alertView.message = "Success Thanks"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
        })
        
    }
    

=======
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
            imageView =  UIImageView(frame:CGRectMake(1000, 1000, 1000, 1000))
            
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
>>>>>>> origin/dev
    
    
}
