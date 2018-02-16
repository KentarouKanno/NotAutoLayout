//
//  MiddleCenterBottom.Individual.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

extension IndividualProperty {
	
	public struct MiddleCenterBottom<ParentView: UIView> {
		
		let middleCenter: LayoutElement.Point<ParentView>
		
		let bottom: LayoutElement.Vertical<ParentView>
		
	}
	
}

// MARK: - Make Frame
extension IndividualProperty.MiddleCenterBottom {
	
	private func makeFrame(middleCenter: CGPoint, bottom: CGFloat, width: CGFloat) -> CGRect {
		
		let height = (bottom - middleCenter.y).doubled
		let x = middleCenter.x - width.halved
		let y = bottom - height
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Length -
// MARK: Width
extension IndividualProperty.MiddleCenterBottom: LayoutPropertyCanStoreWidthToEvaluateFrameType {
	
	public func evaluateFrame(width: LayoutElement.Length, parameters: IndividualFrameCalculationParameters) -> CGRect {
		
		let middleCenter = self.middleCenter.evaluated(from: parameters)
		let bottom = self.bottom.evaluated(from: parameters)
		let height = (bottom - middleCenter.y).doubled
		let width = width.evaluated(from: parameters, withTheOtherAxis: .height(height))
		
		return self.makeFrame(middleCenter: middleCenter, bottom: bottom, width: width)
		
	}
	
}
