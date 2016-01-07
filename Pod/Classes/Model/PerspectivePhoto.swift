
public struct PerspectivePhoto {
  public let URL: NSURL?
  public let photo: UIImage?

  public init(URL: NSURL?, photo: UIImage?) {
    self.URL = URL
    self.photo = photo
  }
}
