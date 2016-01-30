//
//  PostCell.swift
//  MyHood
//
//  Created by Joshua Ide on 30/01/2016.
//  Copyright © 2016 Fox Gallery Studios. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgPost.layer.cornerRadius = imgPost.frame.size.width / 2
        imgPost.clipsToBounds = true
    }
    
    func configureCell(post: Post) {
        lblTitle.text = post.title
        lblDescription.text = post.postDescription
        imgPost.image = DataService.instance.imageForPath(post.imagePath)
    }

}
