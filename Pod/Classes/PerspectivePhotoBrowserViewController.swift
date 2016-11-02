
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

    let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedVertically))
    swipeGestureRecognizer.numberOfTouchesRequired = 1
    swipeGestureRecognizer.direction = [.down]

    self.view.addGestureRecognizer(swipeGestureRecognizer)
  }

  public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    if segue.identifier == "PerspectivePhotoHolderViewController" {
      self.photoHolderViewController = segue.destination as! PerspectivePhotoHolderViewController
      self.photoHolderViewController.photoArray = self.photoArray
      self.photoHolderViewController.startIndex = startIndex
      self.photoHolderViewController.userDidScrollTo = { [unowned self] index in
        if let index = index {
          self.thumbnailViewController.selectThumbnail(atIndex: index)
        }
      }

      return
    }

    if segue.identifier == "PerspectiveThumbnailViewController" {
      self.thumbnailViewController = segue.destination as! PerspectiveThumbnailViewController
      self.thumbnailViewController.photoArray = self.photoArray
      self.thumbnailViewController.startIndex = startIndex
      self.thumbnailViewController.userDidSelectThumbnail = { [unowned self] index in
        self.photoHolderViewController.userDidSelectThumbnail(atIndex: index)
      }

      return
    }
  }

  // MARK: Actions
  func swipedVertically() {
    self.dismiss(animated: true, completion: .none)
  }
  
  // MARK: Actions
  @IBAction func userDidPress(doneButton sender: UIButton) {
    self.dismiss(animated: true, completion: .none)
  }
}
