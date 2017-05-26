//
//  SummaryViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/23/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {

    var interactor:Interactor? = nil
    var testAdvices = Advice.fetchAdvices()
    var lectureNumber = 0
    var lectures:[Lecture] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        let percentThreshold:CGFloat = 0.3
        
        // convert y-position to downward pull progress (percentage)
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        guard let interactor = interactor else { return }
        
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            if(interactor.shouldFinish){
                interactor.finish()
            }else{
                interactor.cancel()
            }
        default: break
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lectures = (UIApplication.shared.delegate as! AppDelegate).lectures

        tableView.dataSource = self
    }

   
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

}


extension SummaryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (lectures[lectureNumber].advices.count)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as! SummaryTableViewCell
        cell.advice = lectures[lectureNumber].advices[indexPath.row]
        return cell
    }
}
