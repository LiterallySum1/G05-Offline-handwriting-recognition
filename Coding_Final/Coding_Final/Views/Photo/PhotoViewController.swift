//
//  PhotoViewController.swift
//  Coding_Final
//
//  Created by Ethan Muller on 18/1/2022.
//

import UIKit
import AVFoundation

class PhotoViewController: UIViewController {

    //MARK: - Variables
    
    var session: AVCaptureSession?
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    var imagePicker = UIImagePickerController()
    
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        return button
    } ()
    
    //MARK: - Viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        checkCameraPermissions()
    }
    
    //MARK: - Functions

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        
        shutterButton.center = CGPoint(x: view.frame.size.width/2,
                                       y: view.frame.size.height - 100)
    }
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            //request
            AVCaptureDevice.requestAccess(for: .video) { granted in
                guard granted
                else {
                    return
                }
                DispatchQueue.main.async {
                    self.setUpCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }

//MARK: - Extensions
extension PhotoViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation()
        else {
            return
        }
        let image = UIImage(data: data)
        session?.stopRunning()
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        view.addSubview(imageView)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "outputScreen")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
}

