//
//  ViewController.swift
//  CoreImageDemo
//
//  Created by Geosat-RD01 on 2016/3/25.
//  Copyright © 2016年 Geosat-RD01. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet var myImg: UIImageView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let image = myImg?.image, cgimg = image.CGImage else{
      print("myImg doesn't have an image!")
      return
    }
    
    //Use CIContext to select GPU or CPU
    let openGLContext = EAGLContext(API: .OpenGLES3)
    let context = CIContext(EAGLContext: openGLContext)
    
    let coreImage = CIImage(CGImage: cgimg)
    
    let sepiaFilter = CIFilter(name: "CISepiaTone")
    sepiaFilter?.setValue(coreImage, forKey: kCIInputImageKey)
    sepiaFilter?.setValue(0.2, forKey: kCIInputIntensityKey)
    
    if let sepiaOutput = sepiaFilter?.valueForKey(kCIOutputImageKey) as? CIImage{
      let exposureFilter = CIFilter(name: "CIExposureAdjust")
      exposureFilter?.setValue(sepiaOutput, forKey: kCIInputImageKey)
      exposureFilter?.setValue(1, forKey: kCIInputEVKey)
      
      if let exposureOutput = exposureFilter?.valueForKey(kCIOutputImageKey) as? CIImage{
        let output = context.createCGImage(exposureOutput, fromRect: exposureOutput.extent)
        let result = UIImage(CGImage: output)
        myImg?.image = result
      }
      
    }else{
      print("image filtering failed")
      
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  func coreImage(){
    guard let image = myImg?.image, cgimg = image.CGImage else{
      print("myImg doesn't have an image!")
      return
    }
    
    //Use CIContext to select GPU or CPU
    let openGLContext = EAGLContext(API: .OpenGLES3)
    let context = CIContext(EAGLContext: openGLContext)
    
    let coreImage = CIImage(CGImage: cgimg)
    
    let filter = CIFilter(name: "CISepiaTone")
    filter?.setValue(coreImage, forKey: kCIInputImageKey)
    filter?.setValue(0.2, forKey: kCIInputIntensityKey)
    
    if let output = filter?.valueForKey(kCIOutputImageKey) as? CIImage{
      let cgimgresult = context.createCGImage(output, fromRect: output.extent)
      let filteredImage = UIImage(CGImage: cgimgresult)
      myImg?.image = filteredImage
      
    }else{
      print("image filtering failed")
      
    }
    
    
  }
  
  
}

