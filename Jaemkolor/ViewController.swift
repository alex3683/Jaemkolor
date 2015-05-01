//
//  ViewController.swift
//  Jaemkolor
//
//  Created by Alexander Wilden on 01.05.15.
//  Copyright (c) 2015 photonics. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var buttonOffset = 3
    let buttonDistance = 20
    
    let redSlider = UISlider()
    let greenSlider = UISlider()
    let blueSlider = UISlider()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        redSlider.minimumValue = 0
        redSlider.maximumValue = 255
        redSlider.frame = CGRectMake(20, 20, 300, 50)
        redSlider.addTarget(self, action: "buttonSetSliderValues", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(redSlider)
        
        greenSlider.minimumValue = 0
        greenSlider.maximumValue = 255
        greenSlider.frame = CGRectMake(20, 70, 300, 50)
        greenSlider.addTarget(self, action: "buttonSetSliderValues", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(greenSlider)
        
        blueSlider.minimumValue = 0
        blueSlider.maximumValue = 255
        blueSlider.frame = CGRectMake(20, 120, 300, 50)
        blueSlider.addTarget(self, action: "buttonSetSliderValues", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(blueSlider)
        
        self.createButton("All Random", withAction: "buttonSetAllRandom")
        self.createButton("All Red", withAction: "buttonSetAllRed")
        self.createButton("All Green", withAction: "buttonSetAllGreen")
        self.createButton("All Blue", withAction: "buttonSetAllBlue")
        self.createButton("Pattern 1", withAction: "buttonSetPattern1")
    }
    
    
    func createButton(title:String, withAction:Selector) {
        var y:Int = buttonOffset * (buttonDistance + 50) + buttonDistance
        ++buttonOffset
        
        let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(100, CGFloat(y), 200, 50)
        button.backgroundColor = UIColor.lightGrayColor()
        button.setTitle(title, forState: UIControlState.Normal)
        button.addTarget(self, action: withAction, forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
    }
    
    
    func buttonSetSliderValues() {
        println("Setting slider values rgb(\(redSlider.value),\(greenSlider.value),\(blueSlider.value)) ")
        var colors:[UInt8] = [0]
        for i in 0...10 {
            colors.append(UInt8(redSlider.value))
            colors.append(UInt8(greenSlider.value))
            colors.append(UInt8(blueSlider.value))
        }
        send(colors)
    }
    

    func buttonSetAllRed() {
        println("Setting all to red")
        var colors:[UInt8] = [0]
        for i in 0...10 {
            colors.append(255)
            colors.append(0)
            colors.append(0)
        }
        send(colors)
    }
    
    
    func buttonSetAllGreen() {
        println("Setting all to green")
        var colors:[UInt8] = [0]
        for i in 0...10 {
            colors.append(0)
            colors.append(255)
            colors.append(0)
        }
        send(colors)
    }
    
    
    func buttonSetAllBlue() {
        println("Setting all to blue")
        var colors:[UInt8] = [0]
        for i in 0...10 {
            colors.append(0)
            colors.append(0)
            colors.append(255)
        }
        send(colors)
    }
    
    
    func buttonSetAllRandom() {
        println("Setting all to random")
        var colors:[UInt8] = [0]
        for i in 0...10 {
            colors.append(UInt8(arc4random_uniform(256)))
            colors.append(UInt8(arc4random_uniform(256)))
            colors.append(UInt8(arc4random_uniform(256)))
        }
        send(colors)
    }
    
    
    func buttonSetPattern1() {
        println("Setting pattern 1")
        var colors:[UInt8] = [0]
        for i in 0...10 {
            colors.append(UInt8((1-i%2)*100))
            colors.append(UInt8(0))
            colors.append(UInt8(i%2*100))
        }
        send(colors)
    }
    
    
    func send(data: [UInt8]) {
        println("Sending \(data)")
        let client:UDPClient = UDPClient(addr: "192.168.98.127", port: 13771)
        
        var (success, msg) = client.send(data: data)
        client.close()
        println("Result: \(success): \(msg)")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

