//
//  InterfaceController.swift
//  MazeWatch WatchKit Extension
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion

class InterfaceController: WKInterfaceController {
	@IBOutlet var bolinha: WKInterfaceImage!
	@IBOutlet var graficoBolinha: WKInterfaceGroup!
	
	var motionManager = CMMotionManager()

	func motionAvailable(_ motion: CMMotionManager, ball: WKInterfaceImage){
		if motion.isAccelerometerAvailable{
			print("Acceloremeter is available")
			motion.accelerometerUpdateInterval = 0.2
			motion.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
				if let myData = data{
					print(myData)
					//print(myData.acceleration.x)

				}
				if error != nil{
					print("Error found \(error.debugDescription)")
				}
			}
//			motion.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
//				if error != nil {
//					print("Error found \(error.debugDescription)")
//				}
//				if let myData = data{
//				}
//			}
		} else{
			print("Not available Acceloremeter")
		}
		
	}

	override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
//		motionAvailable(motionManager)
//		recordingMotion(motionManager)
        super.willActivate()
    }

    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
	
	

}
