//
//  CenterMiddleBottom.Individual.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

extension IndividualProperty {
	
	public struct CenterMiddleBottom<ParentView: UIView> {
		
		let center: LayoutElement.Horizontal<ParentView>
		
		let middle: LayoutElement.Vertical<ParentView>
		
		let bottom: LayoutElement.Vertical<ParentView>
		
	}
	
}

// MARK: - Make Frame
extension IndividualProperty.CenterMiddleBottom {
	
	private func makeFrame(center: CGFloat, middle: CGFloat, bottom: CGFloat, width: CGFloat) -> CGRect {
		
		let x = center - width.halved
		let height = (bottom - middle).doubled
		let y = bottom - height
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Length -
// MARK: Width
extension IndividualProperty.CenterMiddleBottom: LayoutPropertyCanStoreWidthToEvaluateFrameType {
	
	public func evaluateFrame(width: LayoutElement.Length, parameters: IndividualFrameCalculationParameters) -> CGRect {
		
		let center = self.center.evaluated(from: parameters)
		let middle = self.middle.evaluated(from: parameters)
		let bottom = self.bottom.evaluated(from: parameters)
		let height = (bottom - middle).doubled
		let width = width.evaluated(from: parameters, withTheOtherAxis: .height(height))
		
		return self.makeFrame(center: center, middle: middle, bottom: bottom, width: width)
		
	}
	
}
