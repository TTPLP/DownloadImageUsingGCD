//
//  ViewController.swift
//  Dispatch_Work
//
//  Created by David on 2016/2/16.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var imageView: UIImageView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		setupImageView()
	}
	
	func setupImageView() {
		imageView.layer.cornerRadius = 10
		imageView.clipsToBounds = true
		imageView.contentMode = .ScaleAspectFill
	}
	
	func downloadImgage() {
		if let url = NSURL(string: "http://wwwstaff.ari.uni-heidelberg.de/gaia/gallery/GR/gr0283-01.artistic-Gaia-Galaxy-large.jpg") {
			if let data = NSData(contentsOfURL: url) {
				imageView.image = UIImage(data: data)
			}
		}
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		start()
		downloadImgage()
	}
	
	func start() {
		var queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
		var group = dispatch_group_create()
		
		func work1() {
			print("work1 started")
			NSThread.sleepForTimeInterval(10.0)
			print("work1 ended")
		}
		
		func work2() {
			print("work2 started")
			NSThread.sleepForTimeInterval(15.0)
			print("work2 ended")
		}
		
		func work3() {
			print("work3 started")
			NSThread.sleepForTimeInterval(3.0)
			print("work3 ended")
		}
		
		func a1() {
			dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_DEFAULT.rawValue), 0)) { () -> Void in
				NSThread.sleepForTimeInterval(10.0)
			}
		}
		
		func a2() {
			dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_DEFAULT.rawValue), 0)) { () -> Void in
				NSThread.sleepForTimeInterval(10.0)
			}
		}
		
		dispatch_group_async(group, queue) { () -> Void in
			a1()
		}
		
		dispatch_group_async(group, queue) { () -> Void in
			a2()
		}
		
//		dispatch_group_async(group, queue) { () -> Void in
//			work1()
//		}
//		
//		dispatch_group_async(group, queue) { () -> Void in
//			work2()
//		}
//		
//		dispatch_group_async(group, queue) { () -> Void in
//			work3()
//		}
		
		dispatch_group_notify(group, queue) { () -> Void in
			print("ok!")
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

