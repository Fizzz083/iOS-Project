//
//  StartingPageViewController.swift
//  CpNocoloV1.1
//
//  Created by Yousuf Alam on 7/11/21.
//

import UIKit

class StartingPageViewController: UIViewController {
    
    var timer = Timer()
    
    @IBOutlet weak var progressV: UIProgressView!
    @IBOutlet var progressBar: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        progressV.progress = 0.0
        
        var progress: Float = 0.0
        progressV.progress = progress
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
            
            progress += 0.01
            self.progressV.progress = progress
            
            if(self.progressV.progress == 1.0)
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "LoginFirstPage")
                
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        })
        // Do any additional setup after loading the view.
    }
    
    
    func progressRun() {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
