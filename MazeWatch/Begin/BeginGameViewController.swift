//
//  BeginGameViewController.swift
//  MazeWatch
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class BeginGameViewController: UIViewController {
    @IBOutlet weak var btPlay: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btPlay.clipsToBounds = true
        btPlay.layer.cornerRadius = 7.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playPressed(_ sender: Any) {
        let sb = UIStoryboard(name: "Game", bundle: nil)
        guard let controller = sb.instantiateInitialViewController() as? GameViewController else { return }
        present(controller, animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
