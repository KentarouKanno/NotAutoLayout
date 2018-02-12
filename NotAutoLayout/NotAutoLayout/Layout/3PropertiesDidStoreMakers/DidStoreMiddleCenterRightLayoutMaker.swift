//
//  DidStoreMiddleCenterRightLayoutProperty.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreMiddleCenterRightLayoutProperty {
	
	let middleCenter: LayoutElement.Point
	
	let right: LayoutElement.Horizontal
	
}

// MARK: - Make Frame
extension DidStoreMiddleCenterRightLayoutProperty {
	
	private func makeFrame(middleCenter: CGPoint, right: CGFloat, top: CGFloat) -> CGRect {
		
		let height = (middleCenter.y - top).doubled
		
		return self.makeFrame(middleCenter: middleCenter, right: right, height: height)
		
	}
	
	private func makeFrame(middleCenter: CGPoint, right: CGFloat, bottom: CGFloat) -> CGRect {
		
		let height = (bottom - middleCenter.y).doubled
		
		return self.makeFrame(middleCenter: middleCenter, right: right, height: height)
		
	}
	
	private func makeFrame(middleCenter: CGPoint, right: CGFloat, height: CGFloat) -> CGRect {
		
		let width = (right - middleCenter.x).doubled
		let x = right - width
		let y = middleCenter.y - height.halved
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Line -
// MARK: Top
extension DidStoreMiddleCenterRightLayoutProperty: LayoutPropertyCanStoreTopToEvaluateFrameType {
	
	public func evaluateFrame(top: LayoutElement.Vertical, property: ViewFrameProperty) -> CGRect {
		
		let middleCenter = self.middleCenter.evaluated(from: property)
		let right = self.right.evaluated(from: property)
		let top = top.evaluated(from: property)
		
		return self.makeFrame(middleCenter: middleCenter, right: right, top: top)
		
	}
	
}

// MARK: Bottom
extension DidStoreMiddleCenterRightLayoutProperty: LayoutPropertyCanStoreBottomToEvaluateFrameType {
	
	public func evaluateFrame(bottom: LayoutElement.Vertical, property: ViewFrameProperty) -> CGRect {
		
		let middleCenter = self.middleCenter.evaluated(from: property)
		let right = self.right.evaluated(from: property)
		let bottom = bottom.evaluated(from: property)
		
		return self.makeFrame(middleCenter: middleCenter, right: right, bottom: bottom)
		
	}
	
}

// MARK: - Set A Length -
// MARK: Height
extension DidStoreMiddleCenterRightLayoutProperty: LayoutPropertyCanStoreHeightToEvaluateFrameType {
	
	public func evaluateFrame(height: LayoutElement.Length, property: ViewFrameProperty) -> CGRect {
		
		let middleCenter = self.middleCenter.evaluated(from: property)
		let right = self.right.evaluated(from: property)
		let width = (right - middleCenter.x).doubled
		let height = height.evaluated(from: property, withTheOtherAxis: .width(width))
		
		return self.makeFrame(middleCenter: middleCenter, right: right, height: height)
		
	}
	
}