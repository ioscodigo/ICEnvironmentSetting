//
//  DevelopmentSetting.swift
//  TestDevelopment
//
//  Created by Fajar on 5/31/17.
//  Copyright © 2017 Fajar. All rights reserved.
//

import UIKit

public enum ENVIRONMENT {
    case DEVELOPMENT
    case STAGGING
    case PRODUCTION
}

public protocol ICEnvironmentSettingDelegate {
    func reloadEnvironment(environment:ENVIRONMENT)
}

public let ICEnvironmentSetting = ICEnvironment()
private(set) var currentEnvironment:ENVIRONMENT = .DEVELOPMENT
private(set) var BASE_URL_ENV = ""

public class ICEnvironment: NSObject {
    
    let setupVC = UIViewController()
    let setupView = UIView()
    private let selectedColor = UIColor(red:0.07, green:0.46, blue:0.88, alpha:1)
    private let unselectedColor = UIColor(red:0.07, green:0.46, blue:0.88, alpha:0.4)
    private let envString = ["Production","Stagging","Development"]
    private let backView = UIView()
    private let label = UILabel()
    private var currentTag = 1
    private var BASE_URL:[ENVIRONMENT:String] = [.DEVELOPMENT:"",.STAGGING:"",.PRODUCTION:""]
    private var SelectedView:[ENVIRONMENT:UIView] = [.DEVELOPMENT:UIView(),.STAGGING:UIView(),.PRODUCTION:UIView()]
    public var delegate:ICEnvironmentSettingDelegate?
    private var topConstraint:NSLayoutConstraint!
    
    
    override init() {
        super.init()
        setupView.translatesAutoresizingMaskIntoConstraints = false
        backView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        setupView.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.6)
        backView.backgroundColor = UIColor.white
        setupView.addSubview(backView)
        let backLeft = NSLayoutConstraint(item: backView, attribute: .left, relatedBy: .equal, toItem: setupView, attribute: .left, multiplier: 1, constant: 0)
        let backRight = NSLayoutConstraint(item: backView, attribute: .right, relatedBy: .equal, toItem: setupView, attribute: .right, multiplier: 1, constant: 0)
        let backBottom = NSLayoutConstraint(item: backView, attribute: .bottom, relatedBy: .equal, toItem: setupView, attribute: .bottom, multiplier: 1, constant: 0)
        label.text = "Switch data to:"
        backView.addSubview(label)
        let labelTop = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: backView, attribute: .top, multiplier: 1, constant: 20)
        let labelLeft = NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: backView, attribute: .left, multiplier: 1, constant: 25)
        NSLayoutConstraint.activate([backLeft,backRight,backBottom,labelTop,labelLeft])
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideView(_:)))
        tap.numberOfTapsRequired = 1
        setupView.addGestureRecognizer(tap)
        setupView.isHidden = true
    }
    
    private func setupButton(title:String) -> UIView{
        let view = UIView()
        view.backgroundColor = unselectedColor
        view.layer.cornerRadius = 4
        switch title {
        case envString[0]:
            view.tag = 3
            break
        case envString[1]:
            view.tag = 2
            break
        case envString[2]:
            view.tag = 1
            break
        default:
            break
        }
        let label = UILabel()
        label.text = title
        label.textColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        let heigth = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40)
        let labelLeft = NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 13)
        let labelCenterY = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([labelLeft,labelCenterY,heigth])
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideView(_:)))
        view.addGestureRecognizer(tap)
        return view
    }
    
    public func setupBaseURL(development:String,staging:String?,production:String?){
        BASE_URL[ENVIRONMENT.DEVELOPMENT] = development
        var stagView:UIView?
        var prodView:UIView?
        if let stag = staging {
            BASE_URL[ENVIRONMENT.STAGGING] = stag
            stagView = setupButton(title: envString[1])
            stagView?.backgroundColor = currentEnvironment == ENVIRONMENT.STAGGING ? selectedColor : unselectedColor
            currentTag = currentEnvironment == ENVIRONMENT.STAGGING ? 2 : currentTag
        }
        if let prod = production {
            BASE_URL[ENVIRONMENT.PRODUCTION] = prod
            prodView = setupButton(title: envString[0])
            prodView?.backgroundColor = currentEnvironment == ENVIRONMENT.PRODUCTION ? selectedColor : unselectedColor
            currentTag = currentEnvironment == ENVIRONMENT.PRODUCTION ? 3 : currentTag
        }
        let devView = setupButton(title: envString[2])
        devView.backgroundColor = currentEnvironment == ENVIRONMENT.DEVELOPMENT ? selectedColor : unselectedColor
        if stagView == nil && prodView == nil{
            constraintButton(devView, label,true)
        }else{
            constraintButton(devView, label)
            if stagView == nil {
                constraintButton(prodView!,devView,true)
            }
            if prodView == nil {
                constraintButton(stagView!,devView,true)
            }
            if stagView != nil && prodView != nil {
                constraintButton(stagView!,devView)
                constraintButton(prodView!,stagView!,true)
            }
        }
        backView.layoutIfNeeded()
        BASE_URL_ENV = BASE_URL[currentEnvironment]!
        setupView.layoutIfNeeded()
    }
    
    private func constraintButton(_ view:UIView,_ topView:UIView, _ isBot:Bool = false){
        backView.addSubview(view)
        
        let backTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1, constant: topView == label ? 20 : 10)
        let backLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: backView, attribute: .left, multiplier: 1, constant: 20)
        let backRight = NSLayoutConstraint(item: view, attribute: .trailing , relatedBy: .equal, toItem: backView, attribute: .trailing, multiplier: 1, constant: -20)
        if isBot {
            let backBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: backView, attribute: .bottom, multiplier: 1, constant: -28)
            NSLayoutConstraint.activate([backBottom])
        }
        NSLayoutConstraint.activate([backTop,backRight,backLeft])
        view.layoutIfNeeded()
    }
    
    
    public func setup(window:UIWindow, defaultEnv:ENVIRONMENT = .DEVELOPMENT){
        currentEnvironment = defaultEnv
        BASE_URL_ENV = BASE_URL[defaultEnv]!
        window.addSubview(setupView)
        let top = NSLayoutConstraint(item: setupView, attribute: .top, relatedBy: .equal, toItem: window, attribute: .top, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: setupView, attribute: .left, relatedBy: .equal, toItem: window, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: setupView, attribute: .right, relatedBy: .equal, toItem: window, attribute: .right, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: setupView, attribute: .bottom, relatedBy: .equal, toItem: window, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([top,left,right,bottom])
        topConstraint = top
        setupView.layoutIfNeeded()
        backView.layoutIfNeeded()
    }
    
    public func setupTouch(_ view:UIView){
        let touch = UITapGestureRecognizer(target: self, action: #selector(showView(_:)))
        touch.numberOfTouchesRequired = 3
        touch.numberOfTapsRequired = 1
        view.addGestureRecognizer(touch)
        view.isUserInteractionEnabled = true
    }
    
    @objc private func hideView(_ gesture:UITapGestureRecognizer){
        
        let parent = gesture.view!
        if parent != setupView && parent.tag != currentTag{
            parent.superview!.viewWithTag(currentTag)!.backgroundColor = unselectedColor
            parent.backgroundColor = selectedColor
            currentTag = parent.tag
            switch parent.tag {
            case 1:
                currentEnvironment = .DEVELOPMENT
                BASE_URL_ENV = BASE_URL[currentEnvironment]!
                break
            case 2:
                currentEnvironment = .STAGGING
                BASE_URL_ENV = BASE_URL[currentEnvironment]!
                break
            case 3:
                currentEnvironment = .PRODUCTION
                BASE_URL_ENV = BASE_URL[currentEnvironment]!
                break
            default:
                break
            }
            if let del = delegate {
                del.reloadEnvironment(environment: currentEnvironment)
            }
        }
        UIView.animate(withDuration: 0.4) {
            self.backView.frame.origin.y += self.backView.bounds.size.height
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseIn, animations: {
            self.setupView.alpha = 0
        }) { (status) in
            
            self.setupView.isHidden = true
        }
        UIView.animate(withDuration: 0.5, animations: {
            
        }) { (status) in
        }
    }
    
    @objc private func showView(_ gesture:UITapGestureRecognizer){
        
        UIApplication.shared.delegate!.window!?.bringSubview(toFront: setupView)
        self.setupView.alpha = 0
        self.setupView.isHidden = false
        
        self.backView.frame.origin.y = self.setupView.bounds.size.height
        UIView.animate(withDuration: 0.4) {
            self.setupView.alpha = 1
        }
        UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseIn, animations: {
            self.backView.frame.origin.y -= self.backView.bounds.size.height
        }, completion: nil)
    }
    
}

extension String {
    public var ENV:String {
        return BASE_URL_ENV + self
    }
}




