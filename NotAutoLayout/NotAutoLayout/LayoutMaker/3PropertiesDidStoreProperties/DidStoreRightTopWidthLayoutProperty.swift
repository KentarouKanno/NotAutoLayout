//
//  DidStoreRightTopWidthLayoutProperty.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreRightTopWidthLayoutProperty {
	
	let right: LayoutElement.Horizontal
	
	let top: LayoutElement.Vertical
	
	let width: LayoutElement.Length
	
}

// MARK: - Make Frame
extension DidStoreRightTopWidthLayoutProperty {
	
	private func makeFrame(right: CGFloat, top: CGFloat, width: CGFloat, height: CGFloat) -> CGRect {
		
		let x = right - width
		let y = top
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

extension DidStoreRightTopWidthLayoutProperty: LayoutPropertyCanStoreHeightToEvaluateFrameType {
	
	public func evaluateFrame(height: LayoutElement.Length, parameters: IndividualFrameCalculationParameters) -> CGRect {
		
		let right = self.right.evaluated(from: parameters)
		let top = self.top.evaluated(from: parameters)
		let width = self.width.evaluated(from: parameters, withTheOtherAxis: .height(0))
		let height = height.evaluated(from: parameters, withTheOtherAxis: .width(width))
		
		return self.makeFrame(right: right, top: top, width: width, height: height)
		
	}
	
}