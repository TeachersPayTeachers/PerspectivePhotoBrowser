
public struct PerspectivePhoto {
  public let URL: URL?
  public let photo: UIImage?

  public init(URL: URL?, photo: UIImage?) {
    self.URL = URL
    self.photo = photo
  }
}
