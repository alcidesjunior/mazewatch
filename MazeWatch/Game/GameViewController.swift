//
//  GameViewController.swift
//  MazeWatch
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit
import WatchConnectivity
class GameViewController: UIViewController {
//    @IBOutlet var teste: UILabel!
    var session: WCSession?
    override func viewDidLoad() {
        super.viewDidLoad()
        if WCSession.isSupported(){
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension GameViewController: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
        DispatchQueue.main.async(){
            if let coordReceived = message as? [String: Int]{
//                self.teste.text = String(describing: "X: \(String(describing: coordReceived["x"]!)) Y: \(String(describing: coordReceived["y"]!))")
            }
        }
    }
    func sessionDidDeactivate(_ session: WCSession) {}
}
