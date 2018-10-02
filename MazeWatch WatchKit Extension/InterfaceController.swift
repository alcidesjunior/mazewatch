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
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
	@IBOutlet var bolinha: WKInterfaceImage!
	@IBOutlet var graficoBolinha: WKInterfaceGroup!
    var session: WCSession? = WCSession.default
	
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
    @IBAction func getSwipe(_ sender: Any) {
        let direction = sender as! WKSwipeGestureRecognizer
        switch direction.direction {
        case .right:
            sendCoordinate(x: 1, y: 0)
        case .left:
            sendCoordinate(x: -1, y: 0)
        case .down:
            sendCoordinate(x: 0, y: -1)
        case .up:
           sendCoordinate(x: 0, y: 1)
        default:
           sendCoordinate(x: 0, y: 0)
            
        }
    }
    
    //funcao para mandar as coordenadas via WC para o iOS
    
	override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if WCSession.isSupported(){
            session = WCSession.default
            session?.delegate = self
            session?.activate()
            print("sessao ativada")
            
        }

        
    }
    
    func sendCoordinate(x: Int = 0,y: Int = 0){
        if let validSession = session {
            
            let coord = ["x":x,"y":y]
            print(coord["x"]!,coord["y"]!)
            validSession.sendMessage(coord, replyHandler: nil, errorHandler: nil)
        }
    }
    
    override func willActivate() {
        super.willActivate()
    }

    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //done
    }
	

}
