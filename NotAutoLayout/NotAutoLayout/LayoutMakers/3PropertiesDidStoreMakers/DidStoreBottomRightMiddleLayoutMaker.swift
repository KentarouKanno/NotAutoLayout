//
//  DidStoreBottomRightMiddleLayoutMaker.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreBottomRightMiddleLayoutMaker {
	
	public unowned let parentView: UIView
	
	let bottomRight: LayoutElement.Point
	
	let middle: LayoutElement.Line
	
}

// MARK: - Make Frame
extension DidStoreBottomRightMiddleLayoutMaker {
	
	private func makeFrame(bottomRight: CGPoint, middle: CGFloat, width: CGFloat) -> CGRect {
		
		let height = (bottomRight.y - middle).doubled
		let x = bottomRight.x - width
		let y = middle - height.halved
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Length -
// MARK: Width
extension DidStoreBottomRightMiddleLayoutMaker: LayoutMakerCanStoreWidthToEvaluateFrameType {
	
	public typealias WillSetWidthMaker = LayoutEditor
	
	public func evaluateFrame(width: LayoutElement.Length, property: ViewFrameProperty, fittingCalculation: (CGSize) -> CGSize) -> CGRect {
		
		let bottomRight = self.bottomRight.evaluated(from: property)
		let middle = self.middle.evaluated(from: property)
		let height = (bottomRight.y - middle).doubled
		let width = width.evaluated(from: property, fitting: fittingCalculation, withTheOtherAxis: .height(height))
		
		return self.makeFrame(bottomRight: bottomRight, middle: middle, width: width)
		
	}
	
}
