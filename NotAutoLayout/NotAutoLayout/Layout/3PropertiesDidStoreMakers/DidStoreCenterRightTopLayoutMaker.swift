//
//  DidStoreCenterRightTopLayoutProperty.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreCenterRightTopLayoutProperty {
	
	let center: LayoutElement.Horizontal
	
	let right: LayoutElement.Horizontal
	
	let top: LayoutElement.Vertical
	
}

// MARK: - Make Frame
extension DidStoreCenterRightTopLayoutProperty {
	
	private func makeFrame(center: CGFloat, right: CGFloat, top: CGFloat, middle: CGFloat) -> CGRect {
		
		let height = (middle - top).doubled
		
		return self.makeFrame(center: center, right: right, top: top, height: height)
		
	}
	
	private func makeFrame(center: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat) -> CGRect {
		
		let height = bottom - top
		
		return self.makeFrame(center: center, right: right, top: top, height: height)
		
	}
	
	private func makeFrame(center: CGFloat, right: CGFloat, top: CGFloat, height: CGFloat) -> CGRect {
		
		let width = (right - center).doubled
		let x = right - width
		let y = top
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Line -
// MARK: Middle
extension DidStoreCenterRightTopLayoutProperty: LayoutPropertyCanStoreMiddleToEvaluateFrameType {
	
	public func evaluateFrame(middle: LayoutElement.Vertical, property: ViewFrameProperty) -> CGRect {
		
		let center = self.center.evaluated(from: property)
		let right = self.right.evaluated(from: property)
		let top = self.top.evaluated(from: property)
		let middle = middle.evaluated(from: property)
		
		return self.makeFrame(center: center, right: right, top: top, middle: middle)
		
	}
	
}

// MARK: Bottom
extension DidStoreCenterRightTopLayoutProperty: LayoutPropertyCanStoreBottomToEvaluateFrameType {
	
	public func evaluateFrame(bottom: LayoutElement.Vertical, property: ViewFrameProperty) -> CGRect {
		
		let center = self.center.evaluated(from: property)
		let right = self.right.evaluated(from: property)
		let top = self.top.evaluated(from: property)
		let bottom = bottom.evaluated(from: property)
		
		return self.makeFrame(center: center, right: right, top: top, bottom: bottom)
		
	}
	
}

// MARK: - Set A Length -
// MARK: Height
extension DidStoreCenterRightTopLayoutProperty: LayoutPropertyCanStoreHeightToEvaluateFrameType {
	
	public func evaluateFrame(height: LayoutElement.Length, property: ViewFrameProperty) -> CGRect {
		
		let center = self.center.evaluated(from: property)
		let right = self.right.evaluated(from: property)
		let top = self.top.evaluated(from: property)
		let width = (right - center).doubled
		let height = height.evaluated(from: property, withTheOtherAxis: .width(width))
		
		return self.makeFrame(center: center, right: right, top: top, height: height)
		
	}
	
}