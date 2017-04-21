//
//  ViewController.swift
//  MagicGrid
//
//  Created by Vyacheslav Nagornyak on 4/17/17.
//  Copyright © 2017 Vyacheslav Nagornyak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  let numViewPerRow = 15
  var cells = [UIView]()
  var selectedCell: UIView?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    let width = view.frame.width / CGFloat(numViewPerRow)
    let numViewPerColomn = Int(view.frame.height / width)
    
    for j in 0 ... numViewPerColomn {
      for i in 0 ..< numViewPerRow {
        let cellView = UIView()
        cellView.backgroundColor = randomColor()
        cellView.layer.borderWidth = 0.5
        cellView.layer.borderColor = UIColor.black.cgColor
        cellView.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
        view.addSubview(cellView)
        cells.append(cellView)
      }
    }
    
    view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
  }
  
  func handlePan(gesture: UIPanGestureRecognizer) {
    let location = gesture.location(in: view)
    
    let width = view.frame.width / CGFloat(numViewPerRow)
    
    let x = Int(location.x / width)
    let y = Int(location.y / width)
    
    let index = y * self.numViewPerRow + x
    let cell = self.cells[index]
    
    if selectedCell != cell {
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
        self.selectedCell?.layer.transform = CATransform3DIdentity
      }, completion: nil)
    }
    
    selectedCell = cell
    
    view.bringSubview(toFront: cell)
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
      cell.layer.transform = CATransform3DMakeScale(3, 3, 3)
    }, completion: nil)
    
    if gesture.state == .ended {
      UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
        cell.layer.transform = CATransform3DIdentity
      }, completion: { (_) in
        self.selectedCell = nil
      })
    }
  }
  
  private func randomColor() -> UIColor {
    let r = CGFloat(drand48())
    let g = CGFloat(drand48())
    let b = CGFloat(drand48())
    return UIColor(red: r, green: g, blue: b, alpha: 1)
  }
}

