//
//  DidStoreTopLeftBottomLayoutMaker.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreTopLeftBottomLayoutMaker {
	
	public unowned let parentView: UIView
	
	let topLeft: LayoutElement.Point
	
	let bottom: LayoutElement.Line
	
}

// MARK: - Make Frame
extension DidStoreTopLeftBottomLayoutMaker {
	
	private func makeFrame(topLeft: CGPoint, bottom: CGFloat, width: CGFloat) -> CGRect {
		
		let x = topLeft.x
		let y = topLeft.y
		let height = bottom - y
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Length -
// MARK: Width
extension DidStoreTopLeftBottomLayoutMaker: LayoutMakerCanStoreWidthToEvaluateFrameType {
	
	public typealias WillSetWidthMaker = LayoutEditor
	
	public func evaluateFrame(width: LayoutElement.Length, property: ViewFrameProperty, fittingCalculation: (CGSize) -> CGSize) -> CGRect {
		
		let topLeft = self.topLeft.evaluated(from: property)
		let bottom = self.bottom.evaluated(from: property)
		let height = bottom - topLeft.y
		let width = width.evaluated(from: property, fitting: fittingCalculation, withTheOtherAxis: .height(height))
		
		return self.makeFrame(topLeft: topLeft, bottom: bottom, width: width)
		
	}
	
}
