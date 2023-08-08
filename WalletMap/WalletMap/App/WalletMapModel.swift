//
//  WalletMapModel.swift
//  WalletMap
//
//  Created by Ahmed Henawey on 08/08/2023.
//

import SwiftUI
import MindMap

final class WalletMapModel {
    @Published var mesh: Mesh
    @Published var selection: SelectionHandler

    init(mesh: Mesh = Mesh.sampleMesh(),
         selection: SelectionHandler = SelectionHandler()) {
        self.mesh = mesh
        self.selection = selection
    }
}
