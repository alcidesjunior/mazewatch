//
//  AcelerometroInterfaceController.swift
//  MazeWatch WatchKit Extension
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion

struct Acelerometrotype{
    var valorX: Float
    var valorY: Float
    var valorZ: Float
    
    init(valorX: Float = 0.0, valorY: Float = 0.0, valorZ: Float = 0.0) {
        self.valorX = valorX
        self.valorY = valorY
        self.valorZ = valorZ
    }
}

class AcelerometroInterfaceController: WKInterfaceController {

    @IBOutlet var valorX: WKInterfaceLabel!
    @IBOutlet var valorY: WKInterfaceLabel!
    @IBOutlet var valorZ: WKInterfaceLabel!
    
    var acelerometro = [Acelerometrotype()]
    //instancia do coremotion
    var motionManeger = CMMotionManager()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        motionManeger.accelerometerUpdateInterval = 0.2
        motionManeger.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let currentData = data{
                self.valorX.setText(String(currentData.acceleration.x))
                self.valorY.setText(String(currentData.acceleration.y))
                self.valorZ.setText(String(currentData.acceleration.z))
            }
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
