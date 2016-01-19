
import UIKit

protocol PerspectivePhotoViewer {
  var photoArray: [PerspectivePhoto]! { get set }
  var startIndex: Int { get set }
}

public class PerspectivePhotoBrowserViewController: UIViewController, PerspectivePhotoViewer {

  // MARK: PerspectivePhotoViewer
  var photoArray: [PerspectivePhoto]!
  var startIndex: Int = 0

  var photoHolderViewController: PerspectivePhotoHolderViewController!
  var thumbnailViewController: PerspectiveThumbnailViewController!

  // MARK: Actions
  @IBAction func userDidPress(doneButton sender: UIButton) {
    self.dismissViewControllerAnimated(true, completion: .None)
  }

  public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)

    if segue.identifier == "PerspectivePhotoHolderViewController" {
      self.photoHolderViewController = segue.destinationViewController as! PerspectivePhotoHolderViewController
      self.photoHolderViewController.photoArray = self.photoArray
      self.photoHolderViewController.startIndex = startIndex
      self.photoHolderViewController.userDidScrollTo = { [unowned self] index in
        if let index = index {
          self.thumbnailViewController.selectThumbnailAt(index: index)
        }
      }

      return
    }

    if segue.identifier == "PerspectiveThumbnailViewController" {
      self.thumbnailViewController = segue.destinationViewController as! PerspectiveThumbnailViewController
      self.thumbnailViewController.photoArray = self.photoArray
      self.thumbnailViewController.startIndex = startIndex
      self.thumbnailViewController.userDidSelectThumbnail = { [unowned self] index in
        self.photoHolderViewController.userDidSelectThumbnailAt(index: index)
      }

      return
    }
  }
}
