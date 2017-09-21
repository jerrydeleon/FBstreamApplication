//
//  ViewController.swift
//  FBstreamApplication
//
//  Created by Jerry De Leon on 4/4/17.
//  Copyright © 2017 Jerry De Leon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets background picture
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "jerry")!)
        // Do any additional setup after loading the view, typically from a nib.
    

    //let curvedView = CurvedView(frame: view.frame)
       
        //makes yellow background
        
      // curvedView.backgroundColor = .blue;
     //   view.addSubview(curvedView)
        
     
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }
    func handleTap (){
        (0...10).forEach { (_) in
            generateAnimatedViews()
        }
    }

    func generateAnimatedViews(){
        
        // drand goes from 0 to 1 so if its less than .5 it will
        //be a heart otherwise it will be a thumbs up
        let image = drand48() > 0.5 ? #imageLiteral(resourceName: "thumbs_up"): #imageLiteral(resourceName: "heart")

        let imageView = UIImageView(image: image)
        
        
        // this will set the dimension of our icons
        // to have a width and height between 20-30
        let dimension = 20 + drand48() * 10
        
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        // use curved path we created to animate along it
        animation.path=customPath().cgPath
        animation.duration = 2 + drand48() * 3
        animation.fillMode=kCAFillModeForwards
        
        //removes icon from intial point which was at 0,0,30,30
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
        
    }
}

// function is going to return a path

func customPath()->UIBezierPath{
    
    let path = UIBezierPath();
    
    // this sets up the point of the path we are drawing
    
    path.move(to: CGPoint(x:0 , y : 200))
    let endPoint = CGPoint(x:450, y: 200)
    
    let YcoordinateRand = 200 + drand48() * 300

   
    
    
    // cp1 and cp2 are 2 control points that will
    //help us make a curve along our path
    let cp1 = CGPoint(x:100,y:100 - YcoordinateRand)
    let cp2 = CGPoint(x:300,y:300+YcoordinateRand)
    
    // addCurve function takes end point and two controlPoints to make the curve
    
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)

    
    return path
    
}


class CurvedView: UIView{
    override func draw(_ rect: CGRect) {
        // do fancy curved drawing
        
        let path = customPath()
        
        path.lineWidth = 3
        path.stroke()
        
    
        
    }
}

