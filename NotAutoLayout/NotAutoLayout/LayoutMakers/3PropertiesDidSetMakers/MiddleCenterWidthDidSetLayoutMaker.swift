//
//  MiddleCenterWidthDidSetLayoutMaker.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct MiddleCenterWidthDidSetLayoutMaker {
	
	public unowned let parentView: UIView
	
	let middleCenter: LayoutElement.Point
	
	let width: LayoutElement.Length
	
}

extension MiddleCenterWidthDidSetLayoutMaker {
	
	private func makeFrame(middleCenter: CGPoint, width: CGFloat, height: CGFloat) -> CGRect {
		
		let x = middleCenter.x - width.half
		let y = middleCenter.y - height.half
		let size = CGSize(width: width, height: height)
		let origin = CGPoint(x: x, y: y)
		let frame = CGRect(origin: origin, size: size)
		
		return frame
		
	}
	
}

extension MiddleCenterWidthDidSetLayoutMaker: LayoutMakerCanSetHeightToMakeLayoutEditorType {
	
	public typealias WillSetHeightMaker = LayoutEditor
	
	public func makeFrame(height: LayoutElement.Length, parameter: LayoutControlParameter, fittingCalculation: (CGSize) -> CGSize) -> CGRect {
		
		let middleCenter = self.middleCenter.evaluated(from: parameter)
		let width = self.width.evaluated(from: parameter, theOtherAxis: .height(0), fittingCalculation: fittingCalculation)
		let height = height.evaluated(from: parameter, theOtherAxis: .width(width), fittingCalculation: fittingCalculation)
		return self.makeFrame(middleCenter: middleCenter, width: width, height: height)
		
	}
	
}
