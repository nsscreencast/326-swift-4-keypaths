//: [Previous](@previous)

import PlaygroundSupport
import UIKit

let view = UIView()
view.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
view.backgroundColor = .white

let box = UIView()
box.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
box.backgroundColor = .red

view.addSubview(box)

box.translatesAutoresizingMaskIntoConstraints = false


extension UIView {
    
    func pin<LayoutAnchorType, Axis>(_ anchor: KeyPath<UIView, LayoutAnchorType>) -> NSLayoutConstraint
        where LayoutAnchorType : NSLayoutAnchor<Axis> {
            return pin(anchor, to: anchor)
    }
    

    func pin<LayoutAnchorType, Axis>(_ from: KeyPath<UIView, LayoutAnchorType>,
                                     to: KeyPath<UIView, LayoutAnchorType>) -> NSLayoutConstraint
        where LayoutAnchorType : NSLayoutAnchor<Axis> {
        
            guard let parent = superview else { fatalError("must addSubview first") }
            
            let source = self[keyPath: from]
            let target = parent[keyPath: to]
            return source.constraint(equalTo: target)
    }
    
    func pin(_ anchor: KeyPath<UIView, NSLayoutDimension>, to constant: CGFloat) -> NSLayoutConstraint {
        return self[keyPath: anchor].constraint(equalToConstant: constant)
    }
    
}


NSLayoutConstraint.activate([
    box.pin(\.widthAnchor, to: 100),
    box.pin(\.heightAnchor, to: 100),
    box.pin(\UIView.centerXAnchor),
    box.pin(\UIView.centerYAnchor)
])




PlaygroundPage.current.liveView = view

//: [Next](@next)
