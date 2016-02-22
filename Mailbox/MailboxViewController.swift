//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Diana Nedkova on 2/20/16.
//  Copyright © 2016 Diana Nedkova. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImage: UIImageView!
    
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var archiveView: UIImageView!
    
    @IBOutlet weak var laterView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    
 
    @IBOutlet weak var listActionsVIew: UIImageView!
    @IBOutlet weak var deleteView: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    
    
    @IBOutlet weak var menuView: UIImageView!
    
    @IBOutlet weak var inboxView: UIView!
    var messageOriginalX : CGFloat!
    var archiveOriginalX : CGFloat!
    var laterOriginalX : CGFloat!
    var deleteOriginalX : CGFloat!
    var listOriginalX : CGFloat!
    var inboxOriginalX : CGFloat!
    
    
    // bg view colors
    
    let gray = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1)
    let yellow = UIColor(red: 255/255, green: 210/255, blue: 33/255, alpha: 1)
    let brown = UIColor(red: 216/255.0, green: 165/255.0, blue: 117/255.0, alpha: 1.0)
    let green = UIColor(red: 98/255, green: 217/255, blue: 98/255, alpha: 1)
    let red = UIColor(red: 238/255, green: 84/255, blue: 13/255, alpha: 1)
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 1281)
        
        archiveView.alpha = 0
        laterView.alpha = 0
        deleteView.alpha = 0
        listView.alpha = 0
        rescheduleView.alpha = 0
        listActionsVIew.alpha = 0
        
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "didPanMenu:")
        edgeGesture.edges = UIRectEdge.Left
        inboxView.addGestureRecognizer(edgeGesture)
   
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(view)
        
        
        
        if sender.state == UIGestureRecognizerState.Began {
            messageOriginalX = messageView.frame.origin.x
            archiveOriginalX = archiveView.frame.origin.x
            laterOriginalX = laterView.frame.origin.x
            deleteOriginalX = deleteView.frame.origin.x
            listOriginalX = listView.frame.origin.x
            
            laterView.alpha = 0.5
            archiveView.alpha = 0.5
            deleteView.alpha = 0
            listView.alpha = 0
            
            
            

        } else if sender.state == UIGestureRecognizerState.Changed {
            
            messageView.frame.origin.x =  messageOriginalX + translation.x
            
            switch translation.x{
            case -60...(0):
                groupView.backgroundColor = gray
                UIView.animateWithDuration(1.2, animations: { () -> Void in
                    self.laterView.alpha = 1
                })
                
                
            case -260...(-61):
                groupView.backgroundColor = yellow
                archiveView.alpha = 0
                laterView.alpha = 1
                
                laterView.frame.origin.x = laterOriginalX + translation.x + 65
                
            case -320...(-261):
                groupView.backgroundColor = brown
                laterView.alpha = 0
                listView.alpha = 1
                
                listView.frame.origin.x = listOriginalX + translation.x + 260
                
                
            case 1...60:
                groupView.backgroundColor = gray
                UIView.animateWithDuration(1, animations: {
                    
                    self.archiveView.alpha = 1
                    
                })
                
            case 61...260:
                groupView.backgroundColor = green
                archiveView.alpha = 1
                archiveView.frame.origin.x = archiveOriginalX + translation.x - 65
                
            case 261...320:
                groupView.backgroundColor = red
                laterView.alpha = 0
                archiveView.alpha = 0
                deleteView.alpha = 1

                deleteView.frame.origin.x = deleteOriginalX + translation.x - 270
                
            default:
                groupView.backgroundColor = gray
                
            }


        } else if sender.state == UIGestureRecognizerState.Ended {
            
            
            switch translation.x{
                
            case -60...(0):
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageView.frame.origin.x = self.messageOriginalX
                })
                laterView.alpha = 0.5
                
                
            case -260...(-61):
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.frame.origin.x = -320
                    self.laterView.frame.origin.x = 10
                    self.archiveView.alpha = 0
                    self.laterView.alpha = 0
                }, completion: { (Bool) -> Void in
                    self.rescheduleView.alpha = 1
                })
                laterView.frame.origin.x = laterOriginalX
                
            case -320...(-261):
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.frame.origin.x = -320
                    self.listView.frame.origin.x = 10
                    self.archiveView.alpha = 0
                }, completion: { (Bool) -> Void in
                    self.listActionsVIew.alpha = 1
                })
                listView.alpha = 0
                laterView.frame.origin.x = laterOriginalX
                listView.frame.origin.x = listOriginalX
            
            case 1...60:
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageView.frame.origin.x = self.messageOriginalX
                })
                
            case 61...260:
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.frame.origin.x = 320
                    self.archiveView.frame.origin.x = 290
                    self.archiveView.alpha = 0
                })
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    
                    self.feedImage.frame.origin.y = self.feedImage.frame.origin.y  - self.messageView.frame.height
                    }, completion: { (Bool) -> Void in
                        self.messageView.frame.origin.x = 0
                        self.feedImage.frame.origin.y = self.feedImage.frame.origin.y  + self.messageView.frame.height
                })
                archiveView.frame.origin.x = archiveOriginalX
                
            case 261...320:
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.frame.origin.x = 320
                    self.deleteView.frame.origin.x = 290
                    self.laterView.alpha = 0
                    self.deleteView.alpha = 0
                })
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    
                    self.feedImage.frame.origin.y = self.feedImage.frame.origin.y  - self.messageView.frame.height
                    }, completion: { (Bool) -> Void in
                        self.messageView.frame.origin.x = 0
                        self.feedImage.frame.origin.y = self.feedImage.frame.origin.y  + self.messageView.frame.height
                })
                archiveView.frame.origin.x = archiveOriginalX
                deleteView.frame.origin.x = deleteOriginalX
                
            default:
                groupView.backgroundColor = gray
                
            }


        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onTapReschedule(sender: AnyObject) {
        rescheduleView.alpha = 0
        
        
        
        
//        UIView.animateWithDuration(0.4) { () -> Void in
//            self.feedImage.frame.origin.y = self.feedImage.frame.origin.y  - self.messageView.frame.height
//        }
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.feedImage.frame.origin.y = self.feedImage.frame.origin.y  - self.messageView.frame.height
            }, completion: { (Bool) -> Void in
                self.messageView.frame.origin.x = 0
                self.feedImage.frame.origin.y = self.feedImage.frame.origin.y  + self.messageView.frame.height
        })
        
        
    }
    
    @IBAction func onTapListActions(sender: AnyObject) {
        listActionsVIew.alpha = 0
        
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.feedImage.frame.origin.y = self.feedImage.frame.origin.y  - self.messageView.frame.height
            }, completion: { (Bool) -> Void in
                self.messageView.frame.origin.x = 0
                self.feedImage.frame.origin.y = self.feedImage.frame.origin.y  + self.messageView.frame.height
        })
    }
    
    @IBAction func didPanMenu(sender: UIScreenEdgePanGestureRecognizer) {
        
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            inboxOriginalX = inboxView.frame.origin.x
            
            

        } else if sender.state == UIGestureRecognizerState.Changed {
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.inboxView.frame.origin.x = self.inboxOriginalX + translation.x
            })
            
//            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
//                self.inboxView.frame.origin.x = self.inboxOriginalX
//                }, completion: { (Bool) -> Void in
//            })
            

        } else if sender.state == UIGestureRecognizerState.Ended {
        
            switch translation.x {
                
            case 160...320:
                UIView.animateWithDuration(0.6, animations: { () -> Void in
                    self.inboxView.frame.origin.x = self.inboxOriginalX + 320
                })
//                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
//                    self.inboxView.frame.origin.x = self.inboxOriginalX + 320
//                    }, completion: { (Bool) -> Void in
//                })
            case 0...159:
//                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
//                    self.inboxView.frame.origin.x = self.inboxOriginalX
//                    }, completion: { (Bool) -> Void in
//                })
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.inboxView.frame.origin.x = self.inboxOriginalX
                })
            default:
                self.inboxView.frame.origin.x = 0
            }

        }
    }
    
}
