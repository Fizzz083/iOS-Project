//
//  ContestViewController.swift
//  CpNocoloV1.1
//
//  Created by Yousuf Alam on 7/11/21.
//

import UIKit

class ContestViewController: UIViewController,UITableViewDataSource  {
    @IBOutlet weak var blurview: UIView!
    
    var curTime  = Int(NSDate().timeIntervalSince1970)
    
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    
    var item = [ContestListEntry]()
    
    
    
    var str = "this one ... "
    
    
    

    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    var i : Int = 1
    func call()
    {
        if(i > 1) {
            return
        }
        
        view.insertSubview(table, belowSubview: blurview)
    }
    
    override func viewDidLoad() {
       
        
        call()
        super.viewDidLoad()
        blurview.layer.cornerRadius = 15
        
        
        
        
        
        
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(tapforswipe))
        
        swipeleft.direction = .left
        swipeleft.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(swipeleft)
        
        
        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(tapforswipe))
        
        swiperight.direction = .right
        swiperight.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(swiperight)
        i += 1
        
        
        
        
        
        
        table.dataSource = self
        // Do any additional setup after loading the view.s
//
//        let LR1 = CGRect(x:20,y:20, width:100, height:50)
//        let l1 = UILabel(frame: LR1)
//        l1.text = "Hello world!"
//        l1.numberOfLines = 5
//        view.addSubview(l1)
        
        
//        let LR = CGRect(x:150,y:150, width:500, height:200)
//        let l = UILabel(frame: LR)
//
        fetchPostData { (posts) in
            var str1 = " "
            
            var c = 0
            for i in posts.result{
                
                if(i.startTimeSeconds < self.curTime )
                {
                    continue
                }
                c += 1
                        
                if(c >= 20) {
                            break
                }
                else {
                    print(i.startTimeSeconds)
                         
                    self.item.append(i)
                        //str1 = str1+i.name
                }
            }
        }
        
        sleep(4)
        
        
        table.rowHeight = 80
        
        table.reloadData()
        
        print("heklllo  s  " + self.str)
       
//
//        l.text  = self.str
//
//        l.numberOfLines = 5
//
//        view.addSubview(l)
         
         
         
    }
    
    @IBAction func Logout(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.Check = "No id"
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "LoginFirstPage")
        
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
        
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
   
    
    
    
    
    
    func fetchPostData(completionHandler: @escaping (Post)->Void){
        
        print("getting data ... ")
        
        let url = URL(string: "https://codeforces.com/api/contest.list")!
        
        URLSession.shared.dataTask(with: url) {(data,response, error) in
            
            guard let data = data else {
                print("error71")
                return }
            
            do {
                let postsData = try JSONDecoder().decode(Post.self, from: data)
                
                print("done")
                
                completionHandler(postsData)
            }
            catch{
                let error = error
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        
        var fr : CGRect = table.frame
        fr.origin.x = 0
        fr.origin.y =  60
        fr.size.width =  500
        fr.size.height =  1500
        
        table.frame = fr
        
        //table.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        
        return item.count
       }
    
    @IBInspectable var fontSize: CGFloat = 13.0

    @IBInspectable var fontFamily: String = "DIN Light"
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
           //cell.textLabel.font = [UIFont fontWithName:@"Arail" size:12.0f]
//
//           var attrString = NSMutableAttributedString(attributedString: self.attributedText)
//                  attrString.addAttribute(NSFontAttributeName, value: UIFont(name: self.fontFamily, size: self.fontSize)!, range: NSMakeRange(0, attrString.length))
//
//           cell.textLabel?.numberOfLines = 2
//           cell.textLabel?.font = UIFont.systemFont(ofSize: 10.0)
//           cell.textLabel?.text = "\(item[indexPath.row].name)\n\(item[indexPath.row].durationSeconds)"
           
           
           let LR1 = CGRect(x: cell.frame.origin.x + 15, y: cell.frame.origin.y+15, width: cell.frame.size.width , height: cell.frame.size.height/2 )
            let l1 = UILabel(frame: LR1)
           l1.text = item[indexPath.row].name
           l1.font = .boldSystemFont(ofSize: 16)
           l1.numberOfLines = 2
            cell.addSubview(l1)
           l1.lineBreakMode = NSLineBreakMode.byWordWrapping

           l1.numberOfLines = 2
           l1.preferredMaxLayoutWidth = 400
           
           let LR2 = CGRect(x: cell.frame.origin.x + 20, y: cell.frame.origin.y + cell.frame.size.height/2 + 18 , width: cell.frame.size.width , height: cell.frame.size.height/2 )
            let l2 = UILabel(frame: LR2)
           
           let epocTime = TimeInterval(item[indexPath.row].startTimeSeconds) // convert it from milliseconds dividing it by 1000

               let unixTimestamp = NSDate(timeIntervalSince1970: epocTime) //convert unix timestamp to Date

               let dateFormatter = DateFormatter()
               dateFormatter.timeZone = NSTimeZone() as TimeZone?
               dateFormatter.locale = NSLocale.current // NSLocale(localeIdentifier: "en_US_POSIX")
               dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
               dateFormatter.date(from: String(describing: unixTimestamp))

               let updatedTimeStamp = unixTimestamp
               let cellDate = DateFormatter.localizedString(from: updatedTimeStamp as Date, dateStyle: DateFormatter.Style.full, timeStyle: DateFormatter.Style.medium)

               //cell.subtitleLabel.text = cellDate
           
           l2.text = cellDate
           l2.font = .systemFont(ofSize: 13)
           l2.numberOfLines = 1
            cell.addSubview(l2)
            
           
           cell.backgroundColor = UIColor.white
           
//
//           cell.label1.text = item[indexPath.row].name
//           cell.label1.font = .boldSystemFont(ofSize: 14)
//           cell.label2.text = String( item[indexPath.row].startTimeSeconds)

           return cell
    }

}

