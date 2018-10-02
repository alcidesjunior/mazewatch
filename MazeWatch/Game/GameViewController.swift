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

    var timer = Timer()
    var aux = 0
    var maze = [[0,0,1,1],[1,0,0,1],[1,0,1,1],[1,0,0,0],[1,0,0,0]]
    var player : UIView = UIView()
    var playerPosition = CGPoint(x: 0, y: 0)
    var cellSize : CGSize?
    let mazeSize = CGSize(width: 4, height: 5)
    
    var animator: UIDynamicAnimator?
    var collision: UICollisionBehavior = UICollisionBehavior(items: [])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if WCSession.isSupported(){
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }

        animator = UIDynamicAnimator(referenceView: view)
        collision.translatesReferenceBoundsIntoBoundary = true

        
        //Inincializing the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.action), userInfo: nil, repeats: true)
        view.addSubview(player)
        
        cellSize = CGSize(width: view.frame.width/(mazeSize.width), height: view.frame.height/(mazeSize.height))
        setupPlayer()
        let matrix = placeViewsInMatrix(x: Int( mazeSize.width), y: Int( mazeSize.height), screenSize: view.frame, maze: maze)
        
        for squareLine in matrix {
            for square in squareLine{
                if(square.frame.size.width == 0){
                    continue
                }
                view.addSubview(square)
                collision.addItem(square)

            }
        }
        //animator?.addBehavior(collision)
       
    }
    
    func move(player: UIView, toPosition: CGPoint){
        print(player.frame.origin)
        print(toPosition)
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {
                let startpos = player.frame.origin
                player.frame.origin = CGPoint(x: startpos.x + toPosition.x, y: startpos.y + toPosition.y)
            }
        }


    }
    
    func setupPlayer(){
        player.frame.size = CGSize(width: (cellSize?.width)!/2, height: (cellSize?.width)!/2)
        player.layer.anchorPoint = CGPoint(x: player.bounds.width/2, y: player.bounds.height/2)
        player.frame.origin = CGPoint(x: ((cellSize?.width)! - player.frame.width)/2, y: ((cellSize?.height)! - player.frame.height)/2)
        player.layer.cornerRadius = player.frame.width/2
        player.backgroundColor = UIColor.cyan
        //collision.addItem(player)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func action(){
        aux += 1;
    }
    
    @IBAction func btRestarPressed(_ sender: Any) {
        timer.invalidate()
        aux = 0
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
                if(self.checkPlayerBounds(playerPos: self.playerPosition, direction: coordReceived)){
                    
                    self.move(player: self.player, toPosition: self.internProd(cellSize: self.cellSize!, direction: coordReceived))
                    self.playerPosition.x += CGFloat(coordReceived["x"]!)
                    self.playerPosition.y -= CGFloat( coordReceived["y"]!)
                }
//                self.teste.text = String(describing: "X: \(String(describing: coordReceived["x"]!)) Y: \(String(describing: coordReceived["y"]!))")
            }
        }
    }
    func sessionDidDeactivate(_ session: WCSession) {}

    @IBAction func btPausePressed(_ sender: Any) {
        timer.invalidate()
    }
    
    func internProd(cellSize: CGSize, direction: [String: Int])->CGPoint{
        return CGPoint(x: cellSize.width * CGFloat(direction["x"]!), y: cellSize.height * -CGFloat(direction["y"]!))
    }
    func checkPlayerBounds(playerPos: CGPoint, direction: [String: Int])-> Bool{
        if(direction["x"] == -1){
            if(playerPos.x == 0){
                return false
            }
        }
        if(direction["x"] == 1){
            if(playerPos.x == self.mazeSize.width - 1){
                return false
            }
        }
        if(direction["y"] == 1){
            if(playerPos.y == 0){
                return false
            }
        }
        if(direction["y"] == -1){
            if(playerPos.y == self.mazeSize.height - 1){
                return false
            }
        }
        
        
        if(direction["x"] == -1){
            if(self.maze[Int(playerPos.y)][Int(playerPos.x) - 1] == 1){

                return false
            }
        }
        if(direction["x"] == 1){
            if(self.maze[Int(playerPos.y)][Int(playerPos.x) + 1] == 1){

                return false
            }
        }
        if(direction["y"] == 1){
            if(self.maze[Int(playerPos.y) - 1][Int(playerPos.x)] == 1){
                return false
            }
        }
        if(direction["y"] == -1){
            if(self.maze[Int(playerPos.y) + 1][Int(playerPos.x)] == 1){
                return false
            }
        }
        
        
        
        
        
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func placeViewsInMatrix(x: Int, y: Int, screenSize: CGRect, maze: [[Int]]) -> [[UIView]]{
        let viewSize : CGSize = CGSize(width: screenSize.width/CGFloat(x), height: screenSize.height/CGFloat(y))
        var point = CGPoint(x: 0, y: 0)
        var uiviews : [[UIView]] = [[UIView]](repeating: [UIView](repeating: UIView(), count: y), count: x)
        for i in 0..<y {
            for j in 0..<x{
                if(maze[i][j]==1){
                    uiviews[j][i] = createUIView(position: point, size: viewSize, color: .black)
                }
                
                point.x += viewSize.width
            }
            point.x = 0
            point.y += viewSize.height
        }
        return uiviews
    }
    
    func createUIView(position: CGPoint, size: CGSize, color: UIColor)-> UIView{
        var view = UIView()
        view.frame.size = size
        view.frame.origin = position
        view.backgroundColor = color
        return view
    }

}

