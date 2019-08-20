//
//  ViewController.swift
//  ImageZooming
//
//  Created by Harish on 8/20/19.
//  Copyright © 2019 HARISH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var zoom_Image: UIImageView!
    @IBOutlet var scroll_View: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scroll_View.maximumZoomScale = 4.0
        scroll_View.minimumZoomScale = 1.0
        scroll_View.delegate = self
    }
}
extension ViewController:UIScrollViewDelegate{
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return zoom_Image
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scroll_View.zoomScale > 1{
            if let image = zoom_Image.image{
                let rationWidth = zoom_Image.frame.width/image.size.width
                let rationHight = zoom_Image.frame.height / image.size.height
                let ration = rationWidth < rationHight ? rationWidth : rationHight
                let newWidth = image.size.width * ration
                let newHight = image.size.height * ration
                let conditionLeft = newWidth * scrollView.zoomScale > zoom_Image.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - zoom_Image.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditionTop = newHight*scrollView.zoomScale > zoom_Image.frame.height
                let top = 0.5 * (conditionTop ? newHight - zoom_Image.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        }else{
            scrollView.contentInset = .zero
        }
    }
}

