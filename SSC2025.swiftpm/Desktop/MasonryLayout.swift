//
//  File.swift
//  SSC2025
//
//  Created by aplle on 1/18/25.
//

import SwiftUI

struct MasonryLayout:Layout{
    struct Cache{
        var frames:[CGRect]
        var width = 0.0
    }
    
    var columns:Int
    var spacing:Double
    
    
    init(columns: Int = 2, spacing: Double = 5) {
        self.columns = max(1,columns)
        self.spacing = spacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        let width = proposal.replacingUnspecifiedDimensions().width
        let viewFrames = frames(for:subviews , in:width)
        let bottomView = viewFrames.max{ $0.maxY < $1.maxY    } ?? .zero
        
        cache.frames = viewFrames
        cache.width = width
        return CGSize(width: width, height: bottomView.maxY)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        if cache.width != bounds.width{
            cache.frames = frames(for: subviews, in: bounds.width)
            cache.width = bounds.width
        }
       
        
        for index in subviews.indices{
            let frame = cache.frames[index]
            let position = CGPoint(x: bounds.minX + frame.minX, y: bounds.minY + frame.minY)
            
            subviews[index].place(at: position, proposal: ProposedViewSize(frame.size))
        }
    }
    
    func frames(for subviews:Subviews, in totalwidth:Double)->[CGRect]{
        let totalSpacing = spacing * Double(columns - 1)
        let columnWidth = (totalwidth - totalSpacing) / Double(columns)
        let columnWidthWithSpacing = columnWidth + spacing
        let ProposedSize = ProposedViewSize(width: columnWidth, height: nil)
        
        var viewFrames = [CGRect]()
        var columnHeight = Array(repeating: 0.0, count: columns)
        
        for subView in subviews{
            var selectedColumn = 0
            var selectedHeght = Double.greatestFiniteMagnitude
            
            for(columnIndex,height) in columnHeight.enumerated(){
                if height < selectedHeght{
                    selectedColumn = columnIndex
                    selectedHeght = height
                }
            }
            
            let x = Double(selectedColumn) * columnWidthWithSpacing
            let y = columnHeight[selectedColumn]
            
            let size = subView.sizeThatFits(ProposedSize)
            let frame = CGRect(x: x, y: y, width: size.width, height: size.height)
            
            columnHeight[selectedColumn] += size.height + spacing
            viewFrames.append(frame)
            
        }
        return viewFrames
    }
    func makeCache(subviews: Subviews) -> Cache {
        Cache(frames: [])
    }
}
