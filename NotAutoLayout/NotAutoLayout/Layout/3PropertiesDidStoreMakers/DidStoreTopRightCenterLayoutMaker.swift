//
//  DidStoreTopRightCenterLayoutProperty.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreTopRightCenterLayoutProperty {
	
	let topRight: LayoutElement.Point
	
	let center: LayoutElement.Horizontal
	
}

// MARK: - Make Frame
extension DidStoreTopRightCenterLayoutProperty {
	
	private func makeFrame(topRight: CGPoint, center: CGFloat, middle: CGFloat) -> CGRect {
		
		let height = (middle - topRight.y).doubled
		
		return self.makeFrame(topRight: topRight, center: center, height: height)
		
	}
	
	private func makeFrame(topRight: CGPoint, center: CGFloat, bottom: CGFloat) -> CGRect {
		
		let height = bottom - topRight.y
		
		return self.makeFrame(topRight: topRight, center: center, height: height)
		
	}
	
	private func makeFrame(topRight: CGPoint, center: CGFloat, height: CGFloat) -> CGRect {
		
		let width = (topRight.x - center).doubled
		let x = topRight.x - width
		let y = topRight.y
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Line -
// MARK: Middle
extension DidStoreTopRightCenterLayoutProperty: LayoutPropertyCanStoreMiddleToEvaluateFrameType {
	
	public func evaluateFrame(middle: LayoutElement.Vertical, property: ViewFrameProperty) -> CGRect {
		
		let topRight = self.topRight.evaluated(from: property)
		let center = self.center.evaluated(from: property)
		let middle = middle.evaluated(from: property)
		
		return self.makeFrame(topRight: topRight, center: center, middle: middle)
		
	}
	
}

// MARK: Bottom
extension DidStoreTopRightCenterLayoutProperty: LayoutPropertyCanStoreBottomToEvaluateFrameType {
	
	public func evaluateFrame(bottom: LayoutElement.Vertical, property: ViewFrameProperty) -> CGRect {
		
		let topRight = self.topRight.evaluated(from: property)
		let center = self.center.evaluated(from: property)
		let bottom = bottom.evaluated(from: property)
		
		return self.makeFrame(topRight: topRight, center: center, bottom: bottom)
		
	}
	
}

// MARK: - Set A Length -
// MARK: Height
extension DidStoreTopRightCenterLayoutProperty: LayoutPropertyCanStoreHeightToEvaluateFrameType {
	
	public func evaluateFrame(height: LayoutElement.Length, property: ViewFrameProperty) -> CGRect {
		
		let topRight = self.topRight.evaluated(from: property)
		let center = self.center.evaluated(from: property)
		let width = (topRight.x - center).doubled
		let height = height.evaluated(from: property, withTheOtherAxis: .width(width))
		
		return self.makeFrame(topRight: topRight, center: center, height: height)
		
	}
	
}