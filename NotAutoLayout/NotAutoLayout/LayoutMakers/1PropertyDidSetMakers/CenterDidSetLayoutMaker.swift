//
//  CenterDidSetLayoutMaker.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct CenterDidSetLayoutMaker {
	
	public unowned let parentView: UIView
	
	let center: LayoutElement.Line
	
}

// MARK: - Set A Line -
// MARK: Right
extension CenterDidSetLayoutMaker: LayoutMakerCanSetRightType {
	
	public typealias WillSetRightMaker = CenterRightDidSetLayoutMaker
	
	public func setRight(_ right: LayoutElement.Line) -> CenterRightDidSetLayoutMaker {
		
		return .init(parentView: self.parentView,
					 center: self.center,
					 right: right)
		
	}
	
}

// MARK: Top
extension CenterDidSetLayoutMaker: LayoutMakerCanSetTopType {
	
	public typealias WillSetTopMaker = CenterTopDidSetLayoutMaker
	
	public func setTop(_ top: LayoutElement.Line) -> CenterTopDidSetLayoutMaker {
		
		return .init(parentView: self.parentView,
					 center: self.center,
					 top: top)
		
	}
	
}

// MARK: Middle
extension CenterDidSetLayoutMaker: LayoutMakerCanSetMiddleType {
	
	public typealias WillSetMiddleMaker = CenterMiddleDidSetLayoutMaker
	
	public func setMiddle(_ middle: LayoutElement.Line) -> CenterMiddleDidSetLayoutMaker {
		
		return .init(parentView: self.parentView,
					 center: self.center,
					 middle: middle)
		
	}
	
}

// MARK: Bottom
extension CenterDidSetLayoutMaker: LayoutMakerCanSetBottomType {
	
	public typealias WillSetBottomMaker = CenterBottomDidSetLayoutMaker
	
	public func setBottom(_ bottom: LayoutElement.Line) -> CenterBottomDidSetLayoutMaker {
		
		return .init(parentView: self.parentView,
					 center: self.center,
					 bottom: bottom)
		
	}
	
}
