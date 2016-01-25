//
//  ViewController.swift
//  PerspectivePhotoBrowser
//
//  Created by amol-c on 01/05/2016.
//  Copyright (c) 2016 amol-c. All rights reserved.
//

import UIKit
import PerspectivePhotoBrowser

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func userDidOpenPhotoBrowser(sender: UIButton) {
    var photoArray: [PerspectivePhoto] = []
    let totalImageCount = 8
    for var i = 1; i<=totalImageCount; i++ {
      let image = UIImage(named: "image-\(i).jpg")
      let perspectivePhoto = PerspectivePhoto(URL: .None, photo: image)
      photoArray.append(perspectivePhoto)
    }
    let perspectivePhotoBrowser = PerspectiveNavigationController.perspectiveNavigationControllerWith(photoArray, startIndex: 0)
    let _ = perspectivePhotoBrowser.view
    // Change color of bottom bar
    let thumbnailImageViewController = perspectivePhotoBrowser.perspectivePhotoBrowserViewController.thumbnailViewController
    thumbnailImageViewController.highlightBar.backgroundColor = UIColor.greenColor()

    self.presentViewController(perspectivePhotoBrowser, animated: true, completion: .None)
  }
}
