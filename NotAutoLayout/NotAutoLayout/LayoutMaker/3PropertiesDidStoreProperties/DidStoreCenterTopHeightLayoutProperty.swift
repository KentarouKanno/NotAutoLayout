//
//  DidStoreCenterTopHeightLayoutProperty.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreCenterTopHeightLayoutProperty {
	
	let center: LayoutElement.Horizontal
	
	let top: LayoutElement.Vertical
	
	let height: LayoutElement.Length
	
}

// MARK: - Make Frame
extension DidStoreCenterTopHeightLayoutProperty {
	
	private func makeFrame(center: CGFloat, top: CGFloat, height: CGFloat, width: CGFloat) -> CGRect {
		
		let x = center - width.halved
		let y = top
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Length -
// MARK: Width
extension DidStoreCenterTopHeightLayoutProperty: LayoutPropertyCanStoreWidthToEvaluateFrameType {
	
	public func evaluateFrame(width: LayoutElement.Length, parameters: IndividualFrameCalculationParameters) -> CGRect {
		
		let center = self.center.evaluated(from: parameters)
		let top = self.top.evaluated(from: parameters)
		let height = self.height.evaluated(from: parameters, withTheOtherAxis: .width(0))
		let width = width.evaluated(from: parameters, withTheOtherAxis: .height(height))
		
		return self.makeFrame(center: center, top: top, height: height, width: width)
		
	}
	
}
