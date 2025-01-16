//
//  File.swift
//  SSC2025
//
//  Created by aplle on 1/15/25.
//

import Foundation


class Level4Data: ObservableObject {
    @Published var showInfoView: Bool = false
    @Published var showDecrypt: Bool = false
    
    @Published var solved:Bool = false
}
