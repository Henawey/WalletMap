//
//  WalletMapApp.swift
//  WalletMap
//
//  Created by Ahmed Henawey on 06/08/2023.
//

import SwiftUI
import MindMap

@main
struct WalletMapApp: App {
    private let model = WalletMapModel()
    var body: some Scene {
        WindowGroup {
            SurfaceView(mesh: model.mesh,
                        selection: model.selection)
        }
    }
}
