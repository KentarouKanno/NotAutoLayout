//
//  TopRightMiddle.Individual.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

extension IndividualProperty {
	
	public struct TopRightMiddle<ParentView: UIView> {
		
		let topRight: LayoutElement.Point<ParentView>
		
		let middle: LayoutElement.Vertical<ParentView>
		
	}
	
}

// MARK: - Make Frame
extension IndividualProperty.TopRightMiddle {
	
	private func makeFrame(topRight: CGPoint, middle: CGFloat, width: CGFloat) -> CGRect {
		
		let x = topRight.x - width
		let y = topRight.y
		let height = (middle - y).doubled
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Length -
// MARK: Width
extension IndividualProperty.TopRightMiddle: LayoutPropertyCanStoreWidthToEvaluateFrameType {
	
	public func evaluateFrame(width: LayoutElement.Length, parameters: IndividualFrameCalculationParameters) -> CGRect {
		
		let topRight = self.topRight.evaluated(from: parameters)
		let middle = self.middle.evaluated(from: parameters)
		let height = (middle - topRight.y).doubled
		let width = width.evaluated(from: parameters, withTheOtherAxis: .height(height))
		
		return self.makeFrame(topRight: topRight, middle: middle, width: width)
		
	}
	
}
