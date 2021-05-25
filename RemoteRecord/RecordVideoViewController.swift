
import MobileCoreServices
import UIKit
import CameraManager

class RecordVideoViewController: UIViewController {
   
    override func viewDidLoad() {
        
//        let cameraManager = CameraManager()
//        cameraManager.addPreviewLayerToView(self.cameraView)
//
//        cameraManager.capturePictureWithCompletion({ result in
//            switch result {
//            case .failure:
//                break
//            // error handling
//            case .success(let content):
//                break
//            //                    self.myImage = content.asImage;
//            }
//        })
        
//                NotificationCenter.default.addObserver(self, selector: #selector(shootVideo), name: NSNotification.Name(rawValue: "_UIApplicationVolumeUpButtonDownNotification"), object: nil)
//                NotificationCenter.default.addObserver(self, selector: #selector(shootVideo), name: NSNotification.Name(rawValue: "_UIApplicationVolumeDownButtonDownNotification"), object: nil)
    }
    

    
    
    let picker = UIImagePickerController()
    
    @IBAction func record(_ sender: AnyObject) {
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: view.frame.size.height-84, width: view.frame.size.width, height: 54))
        let items = [UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelVideo)),
                     UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                     UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(shootVideo)),
                     UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                     UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)]
        toolbar.setItems(items, animated: false)
        let overlayView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height-84))
        overlayView.isOpaque = false
        overlayView.backgroundColor = .clear
        let cameraView = UIView(frame: view.bounds)
        cameraView.addSubview(overlayView)
        cameraView.addSubview(toolbar)

        picker.sourceType = .camera
        picker.mediaTypes = [kUTTypeMovie as String]
        picker.showsCameraControls = false
        picker.allowsEditing = false
        picker.delegate = self
        picker.videoMaximumDuration = 3600 * 10
        
        picker.cameraOverlayView = cameraView
        
        present(picker, animated: false, completion: nil)
    }
    
    @objc func shootVideo() {
        picker.startVideoCapture()
    }
    @objc func cancelVideo() {
        dismiss(animated: true, completion: nil)
    }
    @objc func video(
        _ videoPath: String,
        didFinishSavingWithError error: Error?,
        contextInfo info: AnyObject
    ) {

    }
}

//// MARK: - UIImagePickerControllerDelegate
extension RecordVideoViewController: UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        dismiss(animated: true, completion: nil)

        guard
            let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
            UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
        else { return }

        // Handle a movie capture
        UISaveVideoAtPathToSavedPhotosAlbum(
            url.path,
            self,
            #selector(video(_:didFinishSavingWithError:contextInfo:)),
            nil)
    }
}

// MARK: - UINavigationControllerDelegate
extension RecordVideoViewController: UINavigationControllerDelegate {
}
