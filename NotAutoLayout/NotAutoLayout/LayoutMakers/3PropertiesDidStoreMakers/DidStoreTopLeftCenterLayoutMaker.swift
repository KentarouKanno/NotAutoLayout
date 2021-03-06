//
//  DidStoreTopLeftCenterLayoutMaker.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreTopLeftCenterLayoutMaker {
	
	public unowned let parentView: UIView
	
	let topLeft: LayoutElement.Point
	
	let center: LayoutElement.Line
	
}

// MARK: - Make Frame
extension DidStoreTopLeftCenterLayoutMaker {
	
	private func makeFrame(topLeft: CGPoint, center: CGFloat, middle: CGFloat) -> CGRect {
		
		let height = (middle - topLeft.y).doubled
		
		return self.makeFrame(topLeft: topLeft, center: center, height: height)
		
	}
	
	private func makeFrame(topLeft: CGPoint, center: CGFloat, bottom: CGFloat) -> CGRect {
		
		let height = bottom - topLeft.y
		
		return self.makeFrame(topLeft: topLeft, center: center, height: height)
		
	}
	
	private func makeFrame(topLeft: CGPoint, center: CGFloat, height: CGFloat) -> CGRect {
		
		let x = topLeft.x
		let y = topLeft.y
		let width = (center - topLeft.x).doubled
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Line -
// MARK: Middle
extension DidStoreTopLeftCenterLayoutMaker: LayoutMakerCanStoreMiddleToEvaluateFrameType {
	
	public typealias WillSetMiddleMaker = LayoutEditor
	
	public func evaluateFrame(middle: LayoutElement.Line, property: ViewFrameProperty) -> CGRect {
		
		let topLeft = self.topLeft.evaluated(from: property)
		let center = self.center.evaluated(from: property)
		let middle = middle.evaluated(from: property)
		
		return self.makeFrame(topLeft: topLeft, center: center, middle: middle)
		
	}
	
}

// MARK: Bottom
extension DidStoreTopLeftCenterLayoutMaker: LayoutMakerCanStoreBottomToEvaluateFrameType {
	
	public typealias WillSetBottomMaker = LayoutEditor
	
	public func evaluateFrame(bottom: LayoutElement.Line, property: ViewFrameProperty) -> CGRect {
		
		let topLeft = self.topLeft.evaluated(from: property)
		let center = self.center.evaluated(from: property)
		let bottom = bottom.evaluated(from: property)
		
		return self.makeFrame(topLeft: topLeft, center: center, bottom: bottom)
		
	}
	
}

// MARK: - Set A Length -
// MARK: Height
extension DidStoreTopLeftCenterLayoutMaker: LayoutMakerCanStoreHeightToEvaluateFrameType {
	
	public typealias WillSetHeightMaker = LayoutEditor
	
	public func evaluateFrame(height: LayoutElement.Length, property: ViewFrameProperty, fittingCalculation: (CGSize) -> CGSize) -> CGRect {
		
		let topLeft = self.topLeft.evaluated(from: property)
		let center = self.center.evaluated(from: property)
		let width = (center - topLeft.x).doubled
		let height = height.evaluated(from: property, fitting: fittingCalculation, withTheOtherAxis: .width(width))
		
		return self.makeFrame(topLeft: topLeft, center: center, height: height)
		
	}
	
}
