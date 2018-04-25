
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
    for i in 1...totalImageCount {
      let image = UIImage(named: "image-\(i).jpg")
      let perspectivePhoto = PerspectivePhoto(URL: nil, photo: image)
      photoArray.append(perspectivePhoto)
    }
    let perspectivePhotoBrowser = PerspectiveNavigationController.perspectiveNavigationControllerWith(photoArray: photoArray, startIndex: 0)
    let _ = perspectivePhotoBrowser.view
    // Change color of bottom bar
    let thumbnailImageViewController = perspectivePhotoBrowser.perspectivePhotoBrowserViewController.thumbnailViewController
    thumbnailImageViewController?.highlightBar.backgroundColor = .green

    self.present(perspectivePhotoBrowser, animated: true, completion: nil)
  }
}
