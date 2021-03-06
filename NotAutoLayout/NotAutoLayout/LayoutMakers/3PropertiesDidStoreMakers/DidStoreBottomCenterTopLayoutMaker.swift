//
//  DidStoreBottomCenterTopLayoutMaker.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreBottomCenterTopLayoutMaker {
	
	public unowned let parentView: UIView
	
	let bottomCenter: LayoutElement.Point
	
	let top: LayoutElement.Line
	
}

// MARK: - Make Frame
extension DidStoreBottomCenterTopLayoutMaker {
	
	private func makeFrame(bottomCenter: CGPoint, top: CGFloat, width: CGFloat) -> CGRect {
		
		let x = bottomCenter.x - width.halved
		let y = top
		let height = bottomCenter.y - top
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Length -
// MARK: Width
extension DidStoreBottomCenterTopLayoutMaker: LayoutMakerCanStoreWidthToEvaluateFrameType {
	
	public typealias WillSetWidthMaker = LayoutEditor
	
	public func evaluateFrame(width: LayoutElement.Length, property: ViewFrameProperty, fittingCalculation: (CGSize) -> CGSize) -> CGRect {
		
		let bottomCenter = self.bottomCenter.evaluated(from: property)
		let top = self.top.evaluated(from: property)
		let height = bottomCenter.y - top
		let width = width.evaluated(from: property, fitting: fittingCalculation, withTheOtherAxis: .height(height))
		
		return self.makeFrame(bottomCenter: bottomCenter, top: top, width: width)
		
	}
	
}
