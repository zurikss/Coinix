//
//  ModeSheetManager.swift
//  Coingate
//
//  Created by Victor on 25/11/2023.
//

import Foundation

final class ModeSheetManager: ObservableObject {
    
    enum Action {
        case na
        case present
        case dismiss
    }
    
    @Published private(set) var action: Action = .na
    
    func present() {
        guard !action.isPresented else { return }
        self.action = .present
    }
    
    func dismiss() {
        self.action = .dismiss
    }
    
}

extension ModeSheetManager.Action{
    var isPresented: Bool { self == .present }
}

