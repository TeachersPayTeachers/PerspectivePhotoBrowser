//
//  PerspectivePhotoBrowserViewController.swift
//  Pods
//
//  Created by Amol Chaudhari on 1/5/16.
//
//

import UIKit

protocol PerspectivePhotoHolder {
  var photoArray: [PerspectivePhoto]! { get set }
}

public class PerspectiveNavigationController: UINavigationController {
  var perspectivePhotoBrowserViewController: PerspectivePhotoBrowserViewController!

  // MARK: Public
  public class func perspectiveNavigationControllerWith(photoArray: [PerspectivePhoto]) -> PerspectiveNavigationController {
    let perspectiveNavigationController = UIStoryboard(name: "PerspectivePhotoBrowserStoryboard", bundle: NSBundle(forClass: self)).instantiateInitialViewController() as! PerspectiveNavigationController

    let perspectivePhotoBrowserViewController = perspectiveNavigationController.viewControllers[0] as! PerspectivePhotoBrowserViewController
    perspectivePhotoBrowserViewController.photoArray = photoArray

    return perspectiveNavigationController
  }
}


public class PerspectivePhotoBrowserViewController: UIViewController, PerspectivePhotoHolder {
  var photoHolderViewController: PerspectivePhotoHolderViewController!
  var thumbnailViewController: PerspectiveThumbnailViewController!
  var photoArray: [PerspectivePhoto]!

  // MARK: Actions
  @IBAction func userDidPress(doneButton sender: UIButton) {
    self.dismissViewControllerAnimated(true, completion: .None)
  }
  
  public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)

    if segue.identifier == "PerspectivePhotoHolderViewController" {
      self.photoHolderViewController = segue.destinationViewController as! PerspectivePhotoHolderViewController
      self.photoHolderViewController.photoArray = self.photoArray

      self.photoHolderViewController.userDidScrollTo = { index in
        if let index = index {
          self.thumbnailViewController.selectThumbnailAt(index: index)
        }
      }

      return
    }

    if segue.identifier == "PerspectiveThumbnailViewController" {
      self.thumbnailViewController = segue.destinationViewController as! PerspectiveThumbnailViewController
      self.thumbnailViewController.photoArray = self.photoArray

      self.thumbnailViewController.userDidSelectThumbnail = { index in
        self.photoHolderViewController.userDidSelectThumbnailAt(index)
      }
      return
    }
  }
}
