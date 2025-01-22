//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/17/25.
//

import SwiftUI
import SceneKit
import UniformTypeIdentifiers

struct TrophyView: View {
    let size:CGSize
    var swipe:(()->Void)?
    var close:(()->Void)?
    
    let fileName: String = "Trophy Prize"
    let sceneName: String = "trophy.scn"
    @State private var showFileExport = false
    @State private var fileURL: URL?
    
    @State private var downloading = false
    var body: some View {
        TrophySceneView()
            .overlay(alignment:.topTrailing){
                Button("Download"){
                    if let scene = SCNScene(named: sceneName) {
                                        fileURL = exportSceneAsSCN(scene: scene, fileName: fileName)
                        showFileExport = true
                                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.init(uiColor: .darkGray))
                .bold()
                .padding()
            }
            .modifier(MacBackgroundStyle(size:.init(width:size.width / 1.3,height: size.height / 1.5), title: "Trophy", movable: true,swipe: {
                swipe?()
            },close:{
                close?()
            }))
            .fileExporter(
                        isPresented: $showFileExport,
                        document: SceneDocument(fileURL: fileURL),
                        contentType: .sceneKitScene,
                        defaultFilename: fileName
                    ) { result in
                        switch result {
                        case .success:
                            print("Export successful!")
                        case .failure(let error):
                            print("Error exporting file: \(error)")
                        }
                    }
        
    }

    func exportSceneAsSCN(scene: SCNScene, fileName: String) -> URL? {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsURL.appendingPathComponent("\(fileName).scn")
        
        do {
           
            try scene.write(to: fileURL, options: nil, delegate: nil, progressHandler: nil)
            print("Scene exported to: \(fileURL)")
            return fileURL
        } catch {
            print("Error exporting scene: \(error)")
            return nil
        }
    }
}

#Preview {
    TrophyView(size: UIScreen.main.bounds.size)
}
struct TrophySceneView: UIViewRepresentable {
    
    class Coordinator: NSObject {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.backgroundColor = UIColor.clear
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.preferredFramesPerSecond = 60
        
        
        if let scene = SCNScene(named: "trophy.scn") {
            sceneView.scene = scene
        } else {
            print("Scene not found!")
        }

        
       
        
        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }

}


struct SceneDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.sceneKitScene] }
    var fileURL: URL?

    init(fileURL: URL?) {
        self.fileURL = fileURL
    }

    init(configuration: ReadConfiguration) throws {
        
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        guard let fileURL = fileURL else {
            throw CocoaError(.fileReadNoSuchFile)
        }
        return try FileWrapper(url: fileURL)
    }
}
