//
//  DocViewController.swift
//  CpNocoloV1.1
//
//  Created by Yousuf Alam on 9/11/21.
//

import UIKit
import Foundation

import Firebase
import FirebaseDatabase
import FirebaseAuth


class DocViewController: UIViewController {

    
    @IBOutlet weak var doctextview: UITextView!
    @IBOutlet weak var enterdoctext: UITextField!
    
    @IBOutlet weak var blurview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(tapforswipe))
        
        swipeleft.direction = .left
        swipeleft.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(swipeleft)
        
        
        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(tapforswipe))
        
        swiperight.direction = .right
        swiperight.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(swiperight)
        
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let id : String = appDelegate.Check
        
        print("Idddd : \(appDelegate.Check)")
        
        let ref = Database.database().reference()
        
        
        ref.child("users").child(id).observe(.value, with: { (snapshot) in
           
            let doc_text : String = snapshot.childSnapshot(forPath: "doc").value as! String ?? "Error"
           
            
            print(doc_text)
            
            self.doctextview.text = doc_text
            //self.enterdoctext.text = doc_text
           // self.enterdoctext.
            
        })
         
    }
    
    @objc func tapforswipe(sender: UISwipeGestureRecognizer)
    {
        if sender.direction == .left {
            UIView.animate(withDuration: 0.35, animations: {
            let moveLeft = CGAffineTransform(translationX: -(self.blurview.bounds.width + 20), y: 0.0)
            self.blurview.transform = moveLeft
            })
        print("left..")
        }
        
        if sender.direction == .right {
            UIView.animate(withDuration: 0.35, animations: {
            let zero = CGAffineTransform(translationX: 0.0, y: 0.0)
                self.blurview.transform = zero
                
            })
            
            print("right..")
            
            //blurview.isHidden = false
        }
    }
    @IBAction func logout(_ sender: Any) {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.Check = "No id"
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "LoginFirstPage")
        
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    /*
    @IBAction func logoutbutton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.Check = "No id"
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "LoginFirstPage")
        
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
    }
    */
    
    @IBAction func update(_ sender: Any) {
        
        let str = self.enterdoctext.text
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let id : String = appDelegate.Check
        
        print("Idddd : \(appDelegate.Check)")
        
        let ref = Database.database().reference()
        
        
        ref.child("users").child(id).child("doc").setValue(str)
        
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
