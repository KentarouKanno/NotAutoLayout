//
//  LayoutPropertyCanStoreFrameType.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/11/12.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public protocol LayoutPropertyCanStoreFrameType: LayoutMakerPropertyType {
	
	associatedtype WillSetFrameProperty: LayoutMakerPropertyType
	
	func storeFrame <ParentView> (_ frame: LayoutElement.Rect, to maker: LayoutMaker<ParentView, Self>) -> LayoutMaker<ParentView, WillSetFrameProperty>
	
}

extension LayoutMaker where Property: LayoutPropertyCanStoreFrameType {
	
	public func setFrame(to frame: CGRect) -> LayoutMaker<ParentView, Property.WillSetFrameProperty> {
		
		let frame = LayoutElement.Rect.constant(frame)
		let maker = self.didSetProperty.storeFrame(frame, to: self)
		
		return maker
		
	}
	
	public func setFrame(by frame: @escaping (_ property: ViewFrameProperty) -> CGRect) -> LayoutMaker<ParentView, Property.WillSetFrameProperty> {
		
		let frame = LayoutElement.Rect.byParent(frame)
		let maker = self.didSetProperty.storeFrame(frame, to: self)
		
		return maker
		
	}
	
}

extension LayoutMaker where Property: LayoutPropertyCanStoreFrameType {
	
    public func stickOnParent(withInsets insets: UIEdgeInsets = .zero) -> LayoutMaker<ParentView, Property.WillSetFrameProperty> {
        
        let frame = LayoutElement.Rect.byParent({ $0.boundFrame.inside(insets) })
        let maker = self.didSetProperty.storeFrame(frame, to: self)
		
		return maker
        
    }
    
    @available(iOS 11.0, *)
    public func stickOnParentSafeArea(withInsets insets: UIEdgeInsets = .zero) -> LayoutMaker<ParentView, Property.WillSetFrameProperty> {
        
        let frame = LayoutElement.Rect.byParent({ $0.safeFrame.inside(insets) })
        let maker = self.didSetProperty.storeFrame(frame, to: self)
        
        return maker

    }
    
}

public protocol LayoutPropertyCanStoreFrameToEvaluateFrameType: LayoutPropertyCanStoreFrameType {
    
    func evaluateFrame(frame: LayoutElement.Rect, parameters: IndividualFrameCalculationParameters) -> CGRect
    
}

extension LayoutPropertyCanStoreFrameToEvaluateFrameType {
	
	public typealias WillSetFrameProperty = IndividualLayout
	
	public func storeFrame <ParentView> (_ frame: LayoutElement.Rect, to maker: LayoutMaker<ParentView, Self>) -> LayoutMaker<ParentView, WillSetFrameProperty> {
		
		let layout = IndividualLayout(frame: { (parameters) -> CGRect in
			return self.evaluateFrame(frame: frame, parameters: parameters)
		})
		let maker = LayoutMaker(parentView: maker.parentView, didSetProperty: layout)
        
        return maker
        
    }
    
}
