//
//  CenterBottomWidth.Individual.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

extension IndividualProperty {
	
	public struct CenterBottomWidth<ParentView: UIView> {
		
		let center: LayoutElement.Horizontal<ParentView>
		
		let bottom: LayoutElement.Vertical<ParentView>
		
		let width: LayoutElement.Length<ParentView>
		
	}
	
}

// MARK: - Make Frame
extension IndividualProperty.CenterBottomWidth {
	
	private func makeFrame(center: CGFloat, bottom: CGFloat, width: CGFloat, height: CGFloat) -> CGRect {
		
		let x = center - width.halved
		let y = bottom - height
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Length -
// MARK: Height
extension IndividualProperty.CenterBottomWidth: LayoutPropertyCanStoreHeightToEvaluateFrameType {
	
	public func evaluateFrame(height: LayoutElement.Length, parameters: IndividualFrameCalculationParameters) -> CGRect {
		
		let center = self.center.evaluated(from: parameters)
		let bottom = self.bottom.evaluated(from: parameters)
		let width = self.width.evaluated(from: parameters, withTheOtherAxis: .height(0))
		let height = height.evaluated(from: parameters, withTheOtherAxis: .width(width))
		
		return self.makeFrame(center: center, bottom: bottom, width: width, height: height)
		
	}
	
}
