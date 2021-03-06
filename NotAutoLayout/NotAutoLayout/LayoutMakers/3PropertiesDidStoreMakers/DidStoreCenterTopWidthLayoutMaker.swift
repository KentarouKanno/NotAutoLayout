//
//  DidStoreCenterTopWidthLayoutMaker.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreCenterTopWidthLayoutMaker {
	
	public unowned let parentView: UIView
	
	let center: LayoutElement.Line
	
	let top: LayoutElement.Line
	
	let width: LayoutElement.Length
	
}

// MARK: - Make Frame
extension DidStoreCenterTopWidthLayoutMaker {
	
	private func makeFrame(center: CGFloat, top: CGFloat, width: CGFloat, height: CGFloat) -> CGRect {
		
		let x = center - width.halved
		let y = top
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

extension DidStoreCenterTopWidthLayoutMaker: LayoutMakerCanStoreHeightToEvaluateFrameType {

    public typealias WillSetHeightMaker = LayoutEditor
    
    public func evaluateFrame(height: LayoutElement.Length, property: ViewFrameProperty, fittingCalculation: (CGSize) -> CGSize) -> CGRect {
        
        let center = self.center.evaluated(from: property)
		let top = self.top.evaluated(from: property)
		let width = self.width.evaluated(from: property, fitting: fittingCalculation, withTheOtherAxis: .height(0))
		let height = height.evaluated(from: property, fitting: fittingCalculation, withTheOtherAxis: .width(width))
		
		return self.makeFrame(center: center, top: top, width: width, height: height)
		
    }

}
