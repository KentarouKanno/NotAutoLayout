//
//  DidStoreBottomLeftHeightLayoutProperty.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreBottomLeftHeightLayoutProperty {
	
	let bottomLeft: LayoutElement.Point
	
	let height: LayoutElement.Length
	
}

// MARK: - Make Frame
extension DidStoreBottomLeftHeightLayoutProperty {
	
	private func makeFrame(bottomLeft: CGPoint, height: CGFloat, width: CGFloat) -> CGRect {
		
		let x = bottomLeft.x
		let y = bottomLeft.y - height
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Length -
// MARK: Width
extension DidStoreBottomLeftHeightLayoutProperty: LayoutPropertyCanStoreWidthToEvaluateFrameType {
	
	public func evaluateFrame(width: LayoutElement.Length, property: ViewFrameProperty) -> CGRect {
		
		let bottomLeft = self.bottomLeft.evaluated(from: property)
		let height = self.height.evaluated(from: property, withTheOtherAxis: .width(0))
		let width = width.evaluated(from: property, withTheOtherAxis: .height(height))
		
		return self.makeFrame(bottomLeft: bottomLeft, height: height, width: width)
		
	}
	
}