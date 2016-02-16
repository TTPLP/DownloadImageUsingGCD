//
//  ViewController2.swift
//  Dispatch_Work
//
//  Created by David on 2016/2/16.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
	
	@IBOutlet weak var imageView1: UIImageView!
	@IBOutlet weak var imageView2: UIImageView!
	@IBOutlet weak var imageView3: UIImageView!
	@IBOutlet weak var imageView4: UIImageView!
	
	let imageURLs = [
		"http://wowslider.com/sliders/demo-7/data/images/ny.jpg",
		"http://www.keenthemes.com/preview/metronic/theme/assets/global/plugins/jcrop/demos/demo_files/image2.jpg",
		"http://ww1.prweb.com/prfiles/2014/04/10/11752526/gI_134971_best-image-web-hosting.png",
		"http://www.keenthemes.com/preview/metronic/theme/assets/global/plugins/jcrop/demos/demo_files/image1.jpg"
	]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setupImageView()
    }
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	func setupImageView() {
		let imageViews = [imageView1, imageView2, imageView3, imageView4]
		for imageView in imageViews {
			imageView.layer.cornerRadius = 5.0
			imageView.clipsToBounds = true
			imageView.contentMode = .ScaleAspectFill
		}
	}
	
	@IBAction func buttonClicked() {
		downloadImageAndShowAtTheSameTime()
	}
	
	@IBAction func downloadImage() {
		let q = dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.rawValue), 0)
		let main_queue = dispatch_get_main_queue()
		dispatch_async(q) { () -> Void in
			if let url = NSURL(string: self.imageURLs[0]) {
				if let data = NSData(contentsOfURL: url) {
					dispatch_async(main_queue, { () -> Void in
						self.imageView1.image = UIImage(data: data)
					})
				}
			}
		}
		
		dispatch_async(q) { () -> Void in
			if let url = NSURL(string: self.imageURLs[1]) {
				if let data = NSData(contentsOfURL: url) {
					dispatch_async(main_queue, { () -> Void in
						self.imageView2.image = UIImage(data: data)
					})
				}
			}
		}
		
		dispatch_async(q) { () -> Void in
			if let url = NSURL(string: self.imageURLs[2]) {
				if let data = NSData(contentsOfURL: url) {
					dispatch_async(main_queue, { () -> Void in
						self.imageView3.image = UIImage(data: data)
					})
				}
			}
		}
		
		dispatch_async(q) { () -> Void in
			if let url = NSURL(string: self.imageURLs[3]) {
				if let data = NSData(contentsOfURL: url) {
					dispatch_async(main_queue, { () -> Void in
						self.imageView4.image = UIImage(data: data)
					})
				}
			}
		}
	}
	
	func downloadImageAndShowAtTheSameTime() {
		let q = dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.rawValue), 0)
		let main_queue = dispatch_get_main_queue()
		
		let group = dispatch_group_create()
		var imageCache: [UIImage?] = [UIImage(), UIImage(), UIImage(), UIImage()]
		
		dispatch_group_async(group, q) { () -> Void in
			if let url = NSURL(string: self.imageURLs[0]) {
				if let data = NSData(contentsOfURL: url) {
					dispatch_async(main_queue, { () -> Void in
						imageCache[0] = UIImage(data: data)
					})
				}
			}
		}
		
		dispatch_group_async(group, q) { () -> Void in
			if let url = NSURL(string: self.imageURLs[1]) {
				if let data = NSData(contentsOfURL: url) {
					dispatch_async(main_queue, { () -> Void in
						imageCache[1] = UIImage(data: data)
					})
				}
			}
		}
		
		dispatch_group_async(group, q) { () -> Void in
			if let url = NSURL(string: self.imageURLs[2]) {
				if let data = NSData(contentsOfURL: url) {
					dispatch_async(main_queue, { () -> Void in
						imageCache[2] = UIImage(data: data)
					})
				}
			}
		}
		
		dispatch_group_async(group, q) { () -> Void in
			if let url = NSURL(string: self.imageURLs[3]) {
				if let data = NSData(contentsOfURL: url) {
					dispatch_async(main_queue, { () -> Void in
						imageCache[3] = UIImage(data: data)
					})
				}
			}
		}
		
		dispatch_group_notify(group, q) { () -> Void in
			dispatch_async(main_queue, { () -> Void in
				self.imageView1.image = imageCache[0]
				self.imageView2.image = imageCache[1]
				self.imageView3.image = imageCache[2]
				self.imageView4.image = imageCache[3]
			})
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
