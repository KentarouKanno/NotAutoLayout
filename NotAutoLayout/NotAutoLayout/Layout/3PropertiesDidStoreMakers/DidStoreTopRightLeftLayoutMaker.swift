//
//  DidStoreTopRightLeftLayoutProperty.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreTopRightLeftLayoutProperty {
	
	let topRight: LayoutElement.Point
	
	let left: LayoutElement.Horizontal
	
}

// MARK: - Make Frame
extension DidStoreTopRightLeftLayoutProperty {
	
	private func makeFrame(topRight: CGPoint, left: CGFloat, middle: CGFloat) -> CGRect {
		
		let height = (middle - topRight.y).doubled
		
		return self.makeFrame(topRight: topRight, left: left, height: height)
		
	}
	
	private func makeFrame(topRight: CGPoint, left: CGFloat, bottom: CGFloat) -> CGRect {
		
		let height = bottom - topRight.y
		
		return self.makeFrame(topRight: topRight, left: left, height: height)
		
	}
	
	private func makeFrame(topRight: CGPoint, left: CGFloat, height: CGFloat) -> CGRect {
		
		let x = left
		let y = topRight.y
		let width = topRight.x - left
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Line -
// MARK: Middle
extension DidStoreTopRightLeftLayoutProperty: LayoutPropertyCanStoreMiddleToEvaluateFrameType {
	
	public func evaluateFrame(middle: LayoutElement.Vertical, property: ViewFrameProperty) -> CGRect {
		
		let topRight = self.topRight.evaluated(from: property)
		let left = self.left.evaluated(from: property)
		let middle = middle.evaluated(from: property)
		
		return self.makeFrame(topRight: topRight, left: left, middle: middle)
		
	}
	
}

// MARK: Bottom
extension DidStoreTopRightLeftLayoutProperty: LayoutPropertyCanStoreBottomToEvaluateFrameType {
	
	public func evaluateFrame(bottom: LayoutElement.Vertical, property: ViewFrameProperty) -> CGRect {
		
		let topRight = self.topRight.evaluated(from: property)
		let left = self.left.evaluated(from: property)
		let bottom = bottom.evaluated(from: property)
		
		return self.makeFrame(topRight: topRight, left: left, bottom: bottom)
		
	}
	
}

// MARK: - Set A Length -
// MARK: Height
extension DidStoreTopRightLeftLayoutProperty: LayoutPropertyCanStoreHeightToEvaluateFrameType {
	
	public func evaluateFrame(height: LayoutElement.Length, property: ViewFrameProperty) -> CGRect {
		
		let topRight = self.topRight.evaluated(from: property)
		let left = self.left.evaluated(from: property)
		let width = topRight.x - left
		let height = height.evaluated(from: property, withTheOtherAxis: .width(width))
		
		return self.makeFrame(topRight: topRight, left: left, height: height)
		
	}
	
}