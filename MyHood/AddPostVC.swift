//
//  AddPostVC.swift
//  MyHood
//
//  Created by Joshua Ide on 30/01/2016.
//  Copyright © 2016 Fox Gallery Studios. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgPost.layer.cornerRadius = imgPost.frame.size.width / 2
        imgPost.clipsToBounds = true
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        txtTitle.delegate = self
        txtDescription.delegate = self
        
        addDoneButtonToKeyboard()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imgPost.image = image
    }

    @IBAction func makePostBtnPressed(sender: AnyObject) {
        if let title = txtTitle.text, let description = txtDescription.text, let img = imgPost.image {
            let imagePath = DataService.instance.saveImageAndCreatePath(img)
            
            let post = Post(imagePath: imagePath, title: title, description: description)
            DataService.instance.addPost(post)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func onCancelPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addPickBtnPressed(sender: UIButton!) {
        sender.setTitle("", forState: .Normal)
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func addDoneButtonToKeyboard() {
        let doneToolbar = UIToolbar(frame: CGRectMake(0, 0, 400, 35))
        doneToolbar.barStyle = UIBarStyle.Default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target:  self, action: Selector("dismissKeyboard"))
        
        var items = [AnyObject]()
        items.append(flexSpace)
        items.append(done)
        doneToolbar.items = items as? [UIBarButtonItem]
        
        self.txtTitle.inputAccessoryView = doneToolbar
        self.txtDescription.inputAccessoryView = doneToolbar
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
