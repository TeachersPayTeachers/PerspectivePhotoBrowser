
import UIKit

public class PerspectivePhotoBrowserViewController: UIViewController, PerspectivePhotoViewer {

  // MARK: PerspectivePhotoViewer
  var photoArray: [PerspectivePhoto]!
  var startIndex: Int = 0

  // MARK: PublicVar
  public var photoHolderViewController: PerspectivePhotoHolderViewController!
  public var thumbnailViewController: PerspectiveThumbnailViewController!

  // Hooks for user interactions
  public var didZoomPhoto: (() -> Void)?
  public var didViewPhotoAtIndex: ((Int) -> Void)?
  public var didDismiss: (() -> Void)?

  // MARK: Overrides
  public override func viewDidLoad() {
    super.viewDidLoad()

    let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(done))
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
        self.thumbnailViewController.selectThumbnail(atIndex: index)
        self.didViewPhotoAtIndex?(index)
      }

      self.photoHolderViewController.userDidZoom = { [unowned self] in
        self.didZoomPhoto?()
      }

      return
    }

    if segue.identifier == "PerspectiveThumbnailViewController" {
      self.thumbnailViewController = segue.destination as! PerspectiveThumbnailViewController
      self.thumbnailViewController.photoArray = self.photoArray
      self.thumbnailViewController.startIndex = startIndex
      self.thumbnailViewController.userDidSelectThumbnail = { [unowned self] index in
        self.photoHolderViewController.userDidSelectThumbnail(atIndex: index)
        self.didViewPhotoAtIndex?(index)
      }

      return
    }
  }

  // MARK: Actions
  @IBAction func done() {
    dismiss(animated: true, completion: didDismiss)
  }
}
