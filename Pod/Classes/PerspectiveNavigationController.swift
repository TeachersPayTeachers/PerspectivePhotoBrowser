
import UIKit

public class PerspectiveNavigationController: UINavigationController {
  public var perspectivePhotoBrowserViewController: PerspectivePhotoBrowserViewController!

  // MARK: Public
  public class func perspectiveNavigationControllerWith(photoArray: [PerspectivePhoto], startIndex: Int = 0) -> PerspectiveNavigationController {
    let perspectiveNavigationController = UIStoryboard(name: "PerspectivePhotoBrowserStoryboard", bundle: NSBundle(forClass: self)).instantiateInitialViewController() as! PerspectiveNavigationController

    let perspectivePhotoBrowserViewController = perspectiveNavigationController.viewControllers[0] as! PerspectivePhotoBrowserViewController
    perspectivePhotoBrowserViewController.photoArray = photoArray
    perspectivePhotoBrowserViewController.startIndex = startIndex

    perspectiveNavigationController.perspectivePhotoBrowserViewController = perspectivePhotoBrowserViewController
    return perspectiveNavigationController
  }
}
