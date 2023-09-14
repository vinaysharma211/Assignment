//
//  DownloadVC.swift
//  TotalityCorpAssignment
//
//  Created by APPLE on 12/09/23.
//

import UIKit

class DownloadVC: UIViewController {
    
    //Oulets of all the label, button, View, StackViews
    //MARK: - IBOutlets
   
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var downloadButtonTC: NSLayoutConstraint!
    
    @IBOutlet weak var candyBustLabel: UILabel!
    @IBOutlet weak var yellowView: CustomView!
    @IBOutlet weak var frontDownloadView: DownloadProgressBarView!
    
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBOutlet weak var downloadButton2: UIButton!
    
    @IBOutlet weak var playButton: CustomButton!
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var customView1: CustomView!
    
    @IBOutlet weak var twoGrayView: UIView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var nextButton: CustomButton!
    
    @IBOutlet weak var topCustomView2: CustomView!
    @IBOutlet weak var stackView2: UIStackView!
    @IBOutlet weak var bottomCustomView2: CustomView!
    
    
    @IBOutlet weak var readyToPlayLabel: UILabel!
    @IBOutlet weak var oswaldLabel: UILabel!
    @IBOutlet weak var stackView3: UIStackView!
    
    var buttonTappedState = false // checking is button tapped or not?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hiding and unhinding the views and buttons
        playButton.isHidden = true
        popUpView.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        
        downloadButton.setTitle("DOWNLOAD 30MB", for: .normal)
        downloadButton.setTitleColor(.white, for: .normal)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.candyBustLabel.alpha = 0
        self.textLabel.alpha = 0
        
        //applying transitions effect on background views
        applyTransitionAnimation(to: yellowView.layer, duration: 0.6, type: .moveIn, subtype: .fromTop)

        applyTransitionAnimation(to: frontDownloadView.layer, duration: 0.6, type: .moveIn, subtype: .fromBottom)
        
        fadeIn(labels: [candyBustLabel, textLabel], completion: {(finished: Bool) -> Void in
        })
        
        //applying transitions effect on background gray views
        animateUI(view1: nil, view2: twoGrayView, view3: nil)
        
    }
    
    //MARK: - IBActions
    
    // User tapping on download button
    @IBAction func downloadButtonTapped(_ sender: UIButton) {

        completeButton.isHidden = false
        compressDownloadButton()

        let progressArray = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6 ,0.7, 0.8 ,0.9, 1]
        
        downloadButton2.setTitle("10 MB / 30 MB", for: .normal)
        downloadButton2.setTitleColor(.white, for: .normal)

        //Showing the progress of download
        var delay = 0.0
        for progress in progressArray {
            Timer.scheduledTimer(withTimeInterval: 0.1 + Double(delay), repeats: false, block: {_ in
                if progress == 1 {
                    self.downloadButton.isHidden = true
                    self.completeButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                       self.updateButtonUI()
                    }
                  
                    
                    self.applyTransitionAnimation(to: self.playButton.layer, duration: 0.2, type: .moveIn, subtype: .fromTop)
                }
                self.frontDownloadView.progress = progress
                
            })
            delay += 0.1
        }
      
        //Updating the UI when download is completed
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateButtonUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateButtonUI() {

        playButton.isHidden = false
        frontDownloadView.isHidden = true
        completeButton.isHidden = true
        blink(duration: 2, delay: 0.0, alpha: 0.7)
    }
    
    // popup view is appeared when user taps on play button
    @IBAction func playButtonTapped(_ sender: CustomButton) {
        popUpView.isHidden = false
        animateUI(view1: customView1, view2: stackView1, view3: nil)
    }
    
    // when pop view is appeared, then on tap of the next button new sub view is appeared and button color changing
    @IBAction func nextButtonTapped(_ sender: CustomButton) {
        
        if buttonTappedState == false {
            buttonTappedState = true
        }

        let buttonColor = sender.backgroundColor?.accessibilityName
        print(buttonColor!)
        if buttonColor! == "green" {
            view1.isHidden = true
            view2.isHidden = false
            animateUI(view1: topCustomView2, view2: stackView2, view3: bottomCustomView2)
            sender.backgroundColor = .black
          
        }
        
        if buttonColor! == "black" {
            view2.isHidden = true
            view3.isHidden = false
            sender.setTitle("Confirm", for: .normal)
            
            self.readyToPlayLabel.alpha = 0
            self.oswaldLabel.alpha = 0
            fadeIn(labels: [readyToPlayLabel, oswaldLabel], completion: {(finished: Bool) -> Void in
            })
            
            animateUI(view1: nil, view2: stackView3, view3: nil)
        }
    }
    
}

extension DownloadVC {
    
    func blink(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, alpha: CGFloat = 0.0) {
           UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseInOut, .autoreverse], animations: {
               self.playButton.alpha = alpha
           }) { completed in
               if completed {
                   self.playButton.alpha = 1
               }
           }
       }
    
    // function for changing contrast of labels
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, labels: [UILabel], completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            for label in labels {
                label.alpha = 1.0
            }
        }, completion: completion)
    }

    // function for providing the animation to background views
    func applyTransitionAnimation(to layer: CALayer, duration: TimeInterval, type: CATransitionType, subtype: CATransitionSubtype) {

            let transition = CATransition()
            transition.duration = duration
            transition.type = type
            transition.subtype = subtype
            layer.add(transition, forKey: nil)
    
        }
    
    func compressDownloadButton() {
        UIView.animate(withDuration: 0.5) {
            self.downloadButtonTC.constant = 80
        }
    }
    
    // function for providing the animation to popup views
    func animateUI(view1: UIView?, view2: UIView?, view3: UIView?) {
        
        view1?.backgroundColor = UIColor.lightGray
        UIView.transition(with: view1 ?? UIView(),
                              duration: 1,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
    
        view2?.isHidden = true
        UIView.animate(withDuration: 0, animations: {
            view2?.frame.origin.x += 400
        }, completion: { done in
            view2?.isHidden = false
            UIView.animate(withDuration: 0.6, animations: {
                view2?.frame.origin.x -= 400
            })
        })
                     
        view3?.isHidden = true
        UIView.animate(withDuration: 0, animations: {
            view3?.frame.origin.y += 30
        }, completion: { done in
            view3?.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                view3?.frame.origin.y -= 30
            })
        })
        
    }
}
