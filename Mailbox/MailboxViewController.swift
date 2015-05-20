//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Sara Lin on 5/20/15.
//  Copyright (c) 2015 Sara Lin. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    let blueColor = UIColor(red: 68/255, green: 170/255, blue:210/255, alpha: 1)
    let yellowColor = UIColor(red: 254/255, green:202/255, blue:22/255, alpha: 1)
    let brownColor = UIColor(red: 206/255, green: 150/255, blue: 98/255, alpha: 1)
    let greenColor = UIColor(red: 85/255, green: 213/255, blue: 80/255, alpha: 1)
    let redColor = UIColor(red: 231/255, green: 61/255, blue: 14/255, alpha: 1)
    let grayColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
    
    @IBOutlet weak var rescheduleButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    
    @IBOutlet weak var showContentButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var leftSwipeView: UIView!
    @IBOutlet weak var rightSwipeView: UIView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    
    var initialMessageOrigin: CGPoint!
    var initialLeftSwipeOrigin: CGPoint!
    var initialRightSwipeOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add gesture
        var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        messageContainerView.userInteractionEnabled = true
        messageContainerView.addGestureRecognizer(panGestureRecognizer)
        
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        contentView.addGestureRecognizer(edgeGesture)
        
        //initiate swipe view colors
        leftSwipeView.backgroundColor = grayColor
        rightSwipeView.backgroundColor = grayColor
        deleteIcon.hidden = true
        listIcon.hidden = true
        
        initialMessageOrigin = messageView.frame.origin
        initialLeftSwipeOrigin = leftSwipeView.frame.origin
        initialRightSwipeOrigin = rightSwipeView.frame.origin
        
        //hide swipe views
        rescheduleButton.hidden = true
        rescheduleButton.alpha = 0
        listButton.hidden = true
        listButton.alpha = 0
        
        showContentButton.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
        var translation = sender.translationInView(view)
        
        if (sender.state == UIGestureRecognizerState.Changed) {
            self.contentView.frame.origin = CGPointMake(translation.x, self.contentView.frame.origin.y)
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            
            if (translation.x <= contentView.frame.width/2) {
                UIView.animateWithDuration(0.2, animations: {
                    self.contentView.frame.origin = CGPointMake(0, 0)
                })
            } else {
                showContentButton.hidden = false
                UIView.animateWithDuration(0.2, animations: {
                    self.contentView.frame.origin = CGPointMake(285, 0)
                })
            }
        }
    }
    
    func onCustomPan(sender: UIPanGestureRecognizer) {
        var translation = sender.translationInView(view)
        
        if (sender.state == UIGestureRecognizerState.Changed) {
            
            self.messageView.frame.origin = CGPointMake(initialMessageOrigin.x + translation.x, self.messageView.frame.origin.y)
            
            // swipe right
            if (translation.x > 0 && translation.x < 60) {
                leftSwipeView.backgroundColor = grayColor
            }
            
            if (translation.x > 60) {
                leftSwipeView.backgroundColor = greenColor
                self.leftSwipeView.frame.origin = CGPointMake(initialLeftSwipeOrigin.x + translation.x - 60, 0)
                archiveIcon.hidden = false
                deleteIcon.hidden = true
            }
            
            if (translation.x > 260) {
                leftSwipeView.backgroundColor = redColor
                archiveIcon.hidden = true
                deleteIcon.hidden = false
            }
            
            // swipe left
            if (translation.x < 0 && translation.x > -60) {
                rightSwipeView.backgroundColor = grayColor
            }
            
            if (translation.x < -60) {
                rightSwipeView.backgroundColor = yellowColor
                self.rightSwipeView.frame.origin = CGPointMake(initialRightSwipeOrigin.x + translation.x + 60, 0)
                laterIcon.hidden = false
                listIcon.hidden = true
            }
            
            if (translation.x < -260) {
                rightSwipeView.backgroundColor = brownColor
                laterIcon.hidden = true
                listIcon.hidden = false
            }
            
            
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            
            // swipe right
            if (translation.x > 0 && translation.x < 60) {
                UIView.animateWithDuration(0.2, animations: {
                    self.messageView.frame.origin = self.initialMessageOrigin
                })
            }
            
            if (translation.x > 60 && translation.x > 60) {
                UIView.animateKeyframesWithDuration(0.6, delay: 0, options: nil, animations: {
                    UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.3, animations: {
                        self.messageView.frame.origin = CGPointMake(320, 0)
                        self.leftSwipeView.frame.origin = CGPoint(x: 0,y: 0)
                    })
                    
                    UIView.addKeyframeWithRelativeStartTime(0.1, relativeDuration: 0.1, animations: {
                        self.leftSwipeView.backgroundColor = self.grayColor
                    })
                    
                    UIView.addKeyframeWithRelativeStartTime(0.3, relativeDuration: 0.3, animations: {
                        self.feedImageView.frame.offset(dx: 0, dy: -self.messageView.frame.height)
                    })
                    
                    }, completion: nil)
            }
            
            // swipe left
            if (translation.x < 0 && translation.x > -60) {
                UIView.animateWithDuration(0.2, animations: {
                    self.messageView.frame.origin = self.initialMessageOrigin
                })
            }
            
            if (translation.x < -60 && translation.x > -260) {
                leftSwipeView.hidden = true
                UIView.animateKeyframesWithDuration(0.6, delay: 0, options: nil, animations: {
                    UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.3, animations: {
                        self.messageView.frame.origin = CGPointMake(-320, 0)
                        self.rightSwipeView.frame.origin = CGPoint(x: 0, y: 0)
                        self.rescheduleButton.hidden = false
                    })
                    
                    UIView.addKeyframeWithRelativeStartTime(0.3, relativeDuration: 0.2, animations: {
                        self.rescheduleButton.alpha = 1
                    })
                    
                    }, completion: { finished in
                        self.leftSwipeView.hidden = false
                })
            }
            
            if (translation.x < -260) {
                leftSwipeView.hidden = true
                UIView.animateKeyframesWithDuration(0.6, delay: 0, options: nil, animations: {
                    UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.3, animations: {
                        self.messageView.frame.origin = CGPointMake(-320, 0)
                        self.rightSwipeView.frame.origin = CGPoint(x: 0, y: 0)
                        self.listButton.hidden = false
                    })
                    
                    UIView.addKeyframeWithRelativeStartTime(0.3, relativeDuration: 0.2, animations: {
                        self.listButton.alpha = 1
                    })
                    
                    }, completion: { finished in
                        self.leftSwipeView.hidden = false
                })
            }
        }
    }
    
    @IBAction func onDismissReschedule(sender: AnyObject) {
        UIView.animateKeyframesWithDuration(0.3, delay: 0, options: nil, animations: {
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.2, animations: {
                self.rescheduleButton.alpha = 0
            })
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.3, animations: {
                self.rescheduleButton.hidden = true
                self.messageView.frame.origin = CGPointMake(0, 0)
                self.rightSwipeView.frame.origin = CGPoint(x: 320, y: 0)
            })
            
            }, completion: nil)
    }
    
    @IBAction func onDismissList(sender: AnyObject) {
        UIView.animateKeyframesWithDuration(0.3, delay: 0, options: nil, animations: {
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.2, animations: {
                self.listButton.alpha = 0
            })
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.3, animations: {
                self.listButton.hidden = true
                self.messageView.frame.origin = CGPointMake(0, 0)
                self.rightSwipeView.frame.origin = CGPoint(x: 320, y: 0)
            })
            
            }, completion: nil)
    }
    
    @IBAction func onDismissMenu(sender: AnyObject) {
        showContentButton.hidden = true
        
        UIView.animateWithDuration(0.2, animations: {
            self.contentView.frame.origin = CGPointMake(0, 0)
        })
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
