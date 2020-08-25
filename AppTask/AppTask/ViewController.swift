//
//  ViewController.swift
//  AppTask
//
//  Created by Appnap WS07 on 25/8/20.
//  Copyright © 2020 Appnap WS07. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import SlideShowMaker

class ViewController: UIViewController {


    var SelectedAssets = [PHAsset]()
    
    
    @IBOutlet weak var pickerButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sepiaButton: UIButton!
    @IBOutlet weak var negativeButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        imageView.frame = CGRect(x: 0, y: 0, width: 375, height: 577)
        pickerButton.frame = CGRect(x: 147, y: 601, width: 75, height: 30)
        
        
    }
    
   
    @IBAction func sepiaAction(_ sender: UIButton)
    {
        let inputImage = imageView.image
        let context = CIContext(options: nil)

        if let currentFilter = CIFilter(name: "CISepiaTone") {
            let beginImage = CIImage(image: inputImage!)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(0.5, forKey: kCIInputIntensityKey)

            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    imageView.image = processedImage
                }
            }
        }
    }
    @IBAction func negativeAction(_ sender: UIButton)
    {
        let inputImage = imageView.image
        let context = CIContext(options: nil)

        if let currentFilter = CIFilter(name: "CIColorInvert") {
            let beginImage = CIImage(image: inputImage!)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    imageView.image = processedImage
                }
            }
        }
    }

    @IBAction func pickerAction(_ sender: UIButton)
    {
        let imagePicker = ImagePickerController()

        presentImagePicker(imagePicker, select: { (asset) in
        }, deselect: { (asset) in
             
        }, cancel: { (assets) in
             
        }, finish: { (assets) in
            print(assets.count)
            for i in 0..<assets.count
            {
                self.SelectedAssets.append(assets[i])
                print(self.SelectedAssets)
            }
            
            let images = self.SelectedAssets
                    
            var audio: AVURLAsset?
            var timeRange: CMTimeRange?
            if let audioURL = Bundle.main.url(forResource: "Sound", withExtension: "mp3") {
                audio = AVURLAsset(url: audioURL)
                let audioDuration = CMTime(seconds: 30, preferredTimescale: audio!.duration.timescale)
                timeRange = CMTimeRange(start: CMTime.zero, duration: audioDuration)
            }
                    
            //let maker = VideoMaker(images: images, transition: ImageTransition.wipeMixed)
                
           // maker.contentMode = .scaleAspectFit
                    
//           maker.exportVideo(audio: audio, audioTimeRange: timeRange, completed: { success, videoURL in
//                if let url = videoURL {
//                    print(url)
//                }
//            }).progress = { progress in
//                print(progress)
//            }
        
        })
    }
    
}

