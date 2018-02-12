//
//  DidStoreLeftRightTopLayoutProperty.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreLeftRightTopLayoutProperty {
	
	let left: LayoutElement.Horizontal
	
	let right: LayoutElement.Horizontal
	
	let top: LayoutElement.Vertical
	
}

// MARK: - Make Frame
extension DidStoreLeftRightTopLayoutProperty {
	
	private func makeFrame(left: CGFloat, right: CGFloat, top: CGFloat, middle: CGFloat) -> CGRect {
		
		let x = left
		let y = top
		let width = right - left
		let height = (middle - top).doubled
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
	private func makeFrame(left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat) -> CGRect {
		
		let x = left
		let y = top
		let width = right - x
		let height = bottom - y
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
	private func makeFrame(left: CGFloat, right: CGFloat, top: CGFloat, height: CGFloat) -> CGRect {
		
		let x = left
		let y = top
		let width = right - x
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Line -
// MARK: Middle
extension DidStoreLeftRightTopLayoutProperty: LayoutPropertyCanStoreMiddleToEvaluateFrameType {
	
	public func evaluateFrame(middle: LayoutElement.Vertical, property: ViewFrameProperty) -> CGRect {
		
		let left = self.left.evaluated(from: property)
		let right = self.right.evaluated(from: property)
		let top = self.top.evaluated(from: property)
		let middle = middle.evaluated(from: property)
		
		return self.makeFrame(left: left, right: right, top: top, middle: middle)
		
	}
	
}

// MARK: Bottom
extension DidStoreLeftRightTopLayoutProperty: LayoutPropertyCanStoreBottomToEvaluateFrameType {
	
	public func evaluateFrame(bottom: LayoutElement.Vertical, property: ViewFrameProperty) -> CGRect {
		
		let left = self.left.evaluated(from: property)
		let right = self.right.evaluated(from: property)
		let top = self.top.evaluated(from: property)
		let bottom = bottom.evaluated(from: property)
		
		return self.makeFrame(left: left, right: right, top: top, bottom: bottom)
		
	}
	
}

// MARK: - Set A Length -
// MARK: Height
extension DidStoreLeftRightTopLayoutProperty: LayoutPropertyCanStoreHeightToEvaluateFrameType {
	
	public func evaluateFrame(height: LayoutElement.Length, property: ViewFrameProperty) -> CGRect {
		
		let left = self.left.evaluated(from: property)
		let right = self.right.evaluated(from: property)
		let top = self.top.evaluated(from: property)
		let width = right - left
		let height = height.evaluated(from: property, withTheOtherAxis: .width(width))
		
		return self.makeFrame(left: left, right: right, top: top, height: height)
		
	}
	
}