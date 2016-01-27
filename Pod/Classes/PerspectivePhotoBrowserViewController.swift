
import UIKit

public class PerspectivePhotoBrowserViewController: UIViewController, PerspectivePhotoViewer {

  // MARK: PerspectivePhotoViewer
  var photoArray: [PerspectivePhoto]!
  var startIndex: Int = 0

  // MARK: PublicVar
  public var photoHolderViewController: PerspectivePhotoHolderViewController!
  public var thumbnailViewController: PerspectiveThumbnailViewController!

  // MARK: Overrides
  public override func viewDidLoad() {
    super.viewDidLoad()

    let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipedVertically")
    swipeGestureRecognizer.numberOfTouchesRequired = 1
    swipeGestureRecognizer.direction = [.Down]

    self.view.addGestureRecognizer(swipeGestureRecognizer)
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

  // MARK: Actions
  func swipedVertically() {
    self.dismissViewControllerAnimated(true, completion: .None)
  }
  
  // MARK: Actions
  @IBAction func userDidPress(doneButton sender: UIButton) {
    self.dismissViewControllerAnimated(true, completion: .None)
  }
}
