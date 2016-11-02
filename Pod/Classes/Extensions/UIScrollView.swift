
extension UIScrollView {
    func zoom(to point: CGPoint, withScale scale: CGFloat, animated: Bool) {
    var x, y, width, height: CGFloat

    //Normalize current content size back to content scale of 1.0f
    width = (self.contentSize.width / self.zoomScale)
    height = (self.contentSize.height / self.zoomScale)
    let contentSize = CGSize(width: width, height: height)

    //translate the zoom point to relative to the content rect
    x = (point.x / self.bounds.size.width) * contentSize.width
    y = (point.y / self.bounds.size.height) * contentSize.height
    let zoomPoint = CGPoint(x: x, y: y)

    //derive the size of the region to zoom to
    width = self.bounds.size.width / scale
    height = self.bounds.size.height / scale
    let zoomSize = CGSize(width: width, height: height)

    //offset the zoom rect so the actual zoom point is in the middle of the rectangle
    x = zoomPoint.x - zoomSize.width / 2.0
    y = zoomPoint.y - zoomSize.height / 2.0
    width = zoomSize.width
    height = zoomSize.height
    let zoomRect = CGRect(x: x, y: y, width: width, height: height)

    //apply the resize
    self.zoom(to: zoomRect, animated: animated)
  }
}
