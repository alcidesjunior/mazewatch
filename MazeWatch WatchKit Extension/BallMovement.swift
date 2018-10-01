//
//  BallMovementInterfaceController.swift
//  MazeWatch WatchKit Extension
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion


class BallMovementInterfaceController{
	
	func motionAvailable(_ motion: CMMotionManager, ball: WKInterfaceImage){
		if motion.isAccelerometerAvailable{
			print("Acceloremeter is available")
			motion.accelerometerUpdateInterval = 0.2
			motion.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
				if error != nil {
					print("Error found \(error.debugDescription)")
				}
				if let myData = data{
					
				}
			}
		} else{
			print("Not available Acceloremeter")
		}
		
	}


}
