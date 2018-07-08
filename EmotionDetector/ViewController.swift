import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UINavigationControllerDelegate {

  let emotionDetector = EmotionDetector.shared
  
  // MARK: - IBOutlets
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var emotionLabel: UILabel!
  @IBOutlet weak var emoticon: UILabel!
  @IBAction func pickImage(_ sender: Any) {
    presentPickerController()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Register to receive notification
    NotificationCenter.default.addObserver(self, selector: #selector(updateLabels), name: Notification.Name("Update Emotion"), object: nil)
  }
  
  @objc
  func updateLabels() {
    DispatchQueue.main.async { [weak self] in
      if let confidence = self?.emotionDetector.confidence, let emotion = self?.emotionDetector.emotion {
        self?.emotionLabel.text = "\(confidence)% it's \(emotion.rawValue)"
        self?.emoticon.text = emotion.emoticon
      }
    }
  }
  
 deinit {
    NotificationCenter.default.removeObserver(self)
  }
}
 

// MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {

  func presentPickerController() {
    let pickerController = UIImagePickerController()
    pickerController.delegate = self
    pickerController.sourceType = .photoLibrary
    present(pickerController, animated: true)
  }

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    dismiss(animated: true)

    guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
      fatalError("couldn't load image from Photos")
    }
    imageView.image = image

    guard let ciImage = CIImage(image: image) else {
      fatalError("couldn't convert UIImage to CIImage")
    }
    emotionLabel.text = "detecting emotion..."
    
    emotionDetector.detectEmotion(image: ciImage)
   
  }
}


