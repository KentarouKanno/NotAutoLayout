//
//  DidStoreTopLeftRightLayoutMaker.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreTopLeftRightLayoutMaker {
	
	public unowned let parentView: UIView
	
	let topLeft: LayoutElement.Point
	
	let right: LayoutElement.Line
	
}

// MARK: - Make Frame
extension DidStoreTopLeftRightLayoutMaker {
	
	private func makeFrame(topLeft: CGPoint, right: CGFloat, middle: CGFloat) -> CGRect {
		
		let height = (middle - topLeft.y).doubled
		
		return self.makeFrame(topLeft: topLeft, right: right, height: height)
		
	}
	
	private func makeFrame(topLeft: CGPoint, right: CGFloat, bottom: CGFloat) -> CGRect {
		
		let height = bottom - topLeft.y
		
		return self.makeFrame(topLeft: topLeft, right: right, height: height)
		
	}
	
	private func makeFrame(topLeft: CGPoint, right: CGFloat, height: CGFloat) -> CGRect {
		
		let x = topLeft.x
		let y = topLeft.y
		let width = right - x
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Line -
// MARK: Middle
extension DidStoreTopLeftRightLayoutMaker: LayoutMakerCanStoreMiddleToEvaluateFrameType {
	
	public typealias WillSetMiddleMaker = LayoutEditor
	
	public func evaluateFrame(middle: LayoutElement.Line, property: ViewFrameProperty) -> CGRect {
		let topLeft = self.topLeft.evaluated(from: property)
		let right = self.right.evaluated(from: property)
		let middle = middle.evaluated(from: property)
		return self.makeFrame(topLeft: topLeft, right: right, middle: middle)
	}
	
}

// MARK: Bottom
extension DidStoreTopLeftRightLayoutMaker: LayoutMakerCanStoreBottomToEvaluateFrameType {
	
	public typealias WillSetBottomMaker = LayoutEditor
	
	public func evaluateFrame(bottom: LayoutElement.Line, property: ViewFrameProperty) -> CGRect {
		
		let topLeft = self.topLeft.evaluated(from: property)
		let right = self.right.evaluated(from: property)
		let bottom = bottom.evaluated(from: property)
		return self.makeFrame(topLeft: topLeft, right: right, bottom: bottom)
		
	}
	
}

// MARK: - Set A Length -
// MARK: Height
extension DidStoreTopLeftRightLayoutMaker: LayoutMakerCanStoreHeightToEvaluateFrameType {
	
	public typealias WillSetHeightMaker = LayoutEditor
	
	public func evaluateFrame(height: LayoutElement.Length, property: ViewFrameProperty, fittingCalculation: (CGSize) -> CGSize) -> CGRect {
		
		let topLeft = self.topLeft.evaluated(from: property)
		let right = self.right.evaluated(from: property)
		let width = right - topLeft.x
		let height = height.evaluated(from: property, fitting: fittingCalculation, withTheOtherAxis: .width(width))
		return self.makeFrame(topLeft: topLeft, right: right, height: height)
		
	}
	
}
