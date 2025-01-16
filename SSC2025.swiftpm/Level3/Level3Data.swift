//
//  File.swift
//  SSC2025
//
//  Created by aplle on 1/15/25.
//

import SwiftUI

class Level3Data: ObservableObject {
    @Published var messages: [Message] = []
    @Published var tips: [Tip] = []
    
    @Published var step:Level3Steps = .start
    @Published var celebrate = false
}
