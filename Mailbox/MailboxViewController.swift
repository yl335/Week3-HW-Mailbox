//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Sara Lin on 5/20/15.
//  Copyright (c) 2015 Sara Lin. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    let brandColor = UIColor(red: 81/255, green: 185/255, blue: 219/255, alpha: 1)
    let blueColor = UIColor(red: 68/255, green: 170/255, blue:210/255, alpha: 1)
    let yellowColor = UIColor(red: 254/255, green:202/255, blue:22/255, alpha: 1)
    let brownColor = UIColor(red: 206/255, green: 150/255, blue: 98/255, alpha: 1)
    let greenColor = UIColor(red: 85/255, green: 213/255, blue: 80/255, alpha: 1)
    let redColor = UIColor(red: 231/255, green: 61/255, blue: 14/255, alpha: 1)
    let grayColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
    
    // for undo
    @IBOutlet weak var undoContainerView: UIView!
    
    // for change tabs
    @IBOutlet weak var blueMessageView: UIScrollView!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueNavView: UIImageView!
    @IBOutlet weak var blueTabView: UIImageView!
    @IBOutlet weak var greenTabView: UIImageView!
    @IBOutlet weak var yellowTabView: UIImageView!
    
    @IBOutlet weak var yellowMessageView: UIImageView!
    @IBOutlet weak var greenMessageView: UIImageView!
    
    @IBOutlet weak var rescheduleButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    
    // for composing email
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var composerContainerView: UIView!
    @IBOutlet weak var composeView: UIImageView!
    
    // for swiping
    @IBOutlet weak var swipeBackgroundView: UIView!
    @IBOutlet weak var showContentButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var leftSwipeView: UIView!
    @IBOutlet weak var rightSwipeView: UIView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    // for swiping icons and actions
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    
    var initialMessageOrigin: CGPoint!
    var initialLeftSwipeOrigin: CGPoint!
    var initialRightSwipeOrigin: CGPoint!
    
    var currentTabColor: String!
    
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
        swipeBackgroundView.backgroundColor = grayColor
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
        composeView.frame.origin = CGPointMake(0, 568)
        composerContainerView.hidden = true
        composerContainerView.alpha = 0
        
        //hide green and yellow tabs, screens
        currentTabColor = "Blue"
        showTabByColor("Blue")
        
        //hide undo container
        undoContainerView.hidden = true
        undoContainerView.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: (UIEvent!)) {
        if(event.subtype == UIEventSubtype.MotionShake) {
            undoContainerView.hidden = false
            UIView.animateWithDuration(0.3, animations: {
                self.undoContainerView.alpha = 1
            })
        }
    }

    
    func showTabByColor(color: String) {
        if (color == "Blue") {
            greenTabView.hidden = true
            yellowTabView.hidden = true
            blueNavView.hidden = false
            blueMessageView.hidden = false
            
            if (currentTabColor == "Yellow") {
                UIView.animateWithDuration(0.3, animations: {
                    self.yellowMessageView.frame.origin = CGPointMake(-320, self.yellowMessageView.frame.origin.y)
                    self.blueMessageView.frame.origin = CGPointMake(0, self.blueMessageView.frame.origin.y)
                    }, completion: { finished in
                        self.yellowMessageView.hidden = true
                })
            } else if (currentTabColor == "Green") {
                UIView.animateWithDuration(0.3, animations: {
                    self.greenMessageView.frame.origin = CGPointMake(320, self.greenMessageView.frame.origin.y)
                    self.blueMessageView.frame.origin = CGPointMake(0, self.blueMessageView.frame.origin.y)
                    }, completion: { finished in
                        self.greenMessageView.hidden = true
                })
            } else {
                yellowMessageView.hidden = true
                greenMessageView.hidden = true
            }
        }
        
        if (color == "Yellow") {
            greenTabView.hidden = true
            yellowTabView.hidden = false
            blueNavView.hidden = true
            yellowMessageView.hidden = false
            
            if (currentTabColor == "Blue") {
                UIView.animateWithDuration(0.3, animations: {
                    self.yellowMessageView.frame.origin = CGPointMake(0, self.yellowMessageView.frame.origin.y)
                    self.blueMessageView.frame.origin = CGPointMake(320, self.blueMessageView.frame.origin.y)
                    }, completion: { finished in
                        self.blueMessageView.hidden = true
                })
            } else if (currentTabColor == "Green") {
                UIView.animateWithDuration(0.3, animations: {
                    self.yellowMessageView.frame.origin = CGPointMake(0, self.yellowMessageView.frame.origin.y)
                    self.greenMessageView.frame.origin = CGPointMake(320, self.greenMessageView.frame.origin.y)
                    }, completion: { finished in
                        self.greenMessageView.hidden = true
                })
            }
        }
        
        if (color == "Green") {
            greenMessageView.hidden = false
            greenTabView.hidden = false
            yellowTabView.hidden = true
            blueNavView.hidden = true
            
            if (currentTabColor == "Blue") {
                UIView.animateWithDuration(0.3, animations: {
                    self.blueMessageView.frame.origin = CGPointMake(-320, self.blueMessageView.frame.origin.y)
                    self.greenMessageView.frame.origin = CGPointMake(0, self.greenMessageView.frame.origin.y)
                    }, completion: { finished in
                        self.blueMessageView.hidden = true
                })
            } else if (currentTabColor == "Yellow") {
                UIView.animateWithDuration(0.3, animations: {
                    self.yellowMessageView.frame.origin = CGPointMake(-320, self.yellowMessageView.frame.origin.y)
                    self.greenMessageView.frame.origin = CGPointMake(0, self.greenMessageView.frame.origin.y)
                    }, completion: { finished in
                        self.yellowMessageView.hidden = true
                })
            }
        }
        
        currentTabColor = color
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
                showMenu()
            }
        }
    }
    
    func showMenu() {
        showContentButton.hidden = false
        UIView.animateWithDuration(0.2, animations: {
            self.contentView.frame.origin = CGPointMake(285, 0)
        })
    }
    
    func onCustomPan(sender: UIPanGestureRecognizer) {
        var translation = sender.translationInView(view)
        
        if (sender.state == UIGestureRecognizerState.Changed) {
            
            self.messageView.frame.origin = CGPointMake(initialMessageOrigin.x + translation.x, self.messageView.frame.origin.y)
            
            // swipe right
            if (translation.x > 0 && translation.x < 60) {
                swipeBackgroundView.backgroundColor = grayColor
                
                var iconAlpha = convertValue(Float(translation.x), 0.0, 60.0, 0.0, 1.0)
                archiveIcon.alpha = CGFloat(iconAlpha)
            }
            
            if (translation.x > 60) {
                swipeBackgroundView.backgroundColor = greenColor
                self.leftSwipeView.frame.origin = CGPointMake(initialLeftSwipeOrigin.x + translation.x - 60, 0)

                archiveIcon.hidden = false
                deleteIcon.hidden = true
            }
            
            if (translation.x > 260) {
                swipeBackgroundView.backgroundColor = redColor
                archiveIcon.hidden = true
                deleteIcon.hidden = false
            }
            
            // swipe left
            if (translation.x < 0 && translation.x > -60) {
                swipeBackgroundView.backgroundColor = grayColor
                
                var iconAlpha = convertValue(Float(translation.x), 0.0, -60.0, 0.0, 1.0)
                laterIcon.alpha = CGFloat(iconAlpha)
                leftSwipeView.hidden = false
            }
            
            if (translation.x < -60) {
                swipeBackgroundView.backgroundColor = yellowColor
                self.rightSwipeView.frame.origin = CGPointMake(initialRightSwipeOrigin.x + translation.x + 60, 0)
                laterIcon.hidden = false
                listIcon.hidden = true
                
                leftSwipeView.hidden = true
            }
            
            if (translation.x < -260) {
                swipeBackgroundView.backgroundColor = brownColor
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
                        self.swipeBackgroundView.backgroundColor = self.grayColor
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
                
                leftSwipeView.hidden = false
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
        UIView.animateKeyframesWithDuration(0.5, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: {
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.2, animations: {
                self.rescheduleButton.alpha = 0
            })
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.5, animations: {
                self.rescheduleButton.hidden = true
                self.messageView.frame.origin = CGPointMake(0, 0)
                self.rightSwipeView.frame.origin = CGPoint(x: 320, y: 0)
            })
            
            }, completion: nil)
    }
    
    @IBAction func onDismissList(sender: AnyObject) {
        UIView.animateKeyframesWithDuration(0.3, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: {
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
    
    @IBAction func onPressComposeButton(sender: AnyObject) {
        self.composerContainerView.hidden = false
        self.toTextField.becomeFirstResponder()
        
        UIView.animateWithDuration(0.3, animations: {
            self.composerContainerView.alpha = 1
            self.composeView.frame.origin = CGPointMake(0, 20)
            
        })
    }
    
    @IBAction func onPressCancelComposeButton(sender: AnyObject) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        optionMenu.view.tintColor = brandColor
        
        let deleteDraft = UIAlertAction(title: "Delete Draft", style: .Destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            self.cancelCompose()
        })
        
        let keepDraft = UIAlertAction(title: "Keep Draft", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.cancelCompose()

        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            self.cancelCompose()
        })
        
        optionMenu.addAction(deleteDraft)
        optionMenu.addAction(keepDraft)
        optionMenu.addAction(cancel)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    func cancelCompose() {
        UIView.animateWithDuration(0.3, animations: {
            self.composerContainerView.alpha = 0
            self.composeView.frame.origin = CGPointMake(0, 568)
            
        })
        self.composerContainerView.hidden = true
        view.endEditing(true)
    }
    
    @IBAction func onPressYellowTab(sender: AnyObject) {
        showTabByColor("Yellow")
    }
    
    @IBAction func onPressBlueTab(sender: AnyObject) {
        showTabByColor("Blue")
    }
    
    @IBAction func onPressGreenTab(sender: AnyObject) {
        showTabByColor("Green")
    }
    
    @IBAction func onPressMenuButton(sender: AnyObject) {
        showMenu()
    }
    
    @IBAction func onPressUndoButton(sender: AnyObject) {
        messageView.frame.origin.x = 0
        
        UIView.animateKeyframesWithDuration(0.6, delay: 0, options: nil, animations: {
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.2, animations: {
                self.undoContainerView.alpha = 0
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.2, relativeDuration: 0.4, animations: {
                self.feedImageView.frame.offset(dx: 0, dy: self.messageView.frame.height)
            })
        
            }, completion: { finished in
                self.undoContainerView.hidden = true
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
