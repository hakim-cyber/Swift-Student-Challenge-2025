//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/17/25.
//

import SwiftUI
import UniformTypeIdentifiers
enum CertificateSteps: Int, CaseIterable{
    case front
    case back
   
}

struct CertficicatePreviewView: View {
    let size:CGSize
    @EnvironmentObject var data:ProjectData
    @State private var selectedStep: Int = 0
    @State private var scale: CGFloat = 0.8
    @State private var lastScale: CGFloat = 0.8
    
    @State private var docToSave:([ImageDocument],UTType) = ([],.png)
    
    @State private var showFileExport = false
    
    @State private var downloading = false
    var swipe:(()->Void)?
    var close:(()->Void)?
    var body: some View {
        GeometryReader{ geo in
            let size = geo.size
            HStack(spacing: 0) {
                
               
                
                ScrollView(.vertical){
                    VStack(spacing:20){
                        
                        ForEach(0...1,id:\.self) { count in
                            
                            Button {
                                self.selectedStep = count
                            } label: {
                                VStack {
                                   
                                    switch count{
                                    case 0:
                                        CertificateFrontView(size: size.width * 0.15 - 35)
                                    case 1:
                                        CertificateBackView(size: size.width * 0.15 - 35,userName: data.userName)
                                    default:
                                        CertificateFrontView(size: size.width * 0.15 - 35)
                                    }
                                    Text("\(count + 1)")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .fixedSize()
                                        .bold()
                                        .padding(5)
                                        .background{
                                            RoundedRectangle(cornerRadius: 6)
                                                .fill(selectedStep == count ? Color.gray.opacity(0.2) :Color.clear)
                                        }
                                }
                            }
                            
                        }
                        Color.clear.frame(height: 100)
                    }
                    .padding(.top)
                    
                    
                }
                
                
                .frame(width: size.width * 0.15)
                .background(.thinMaterial)
                .overlay(alignment:.bottom){
                    if !downloading{
                        Button("Download"){
                            self.downloadCertificates()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.secondary)
                        .bold()
                        .padding(.bottom)
                    }else{
                        ProgressView()
                            .padding(.bottom)
                    }
                    
                   
                }
                Spacer()
                ScrollView(.vertical,showsIndicators: false){
                    VStack(spacing: 0) {
                        
                        switch selectedStep{
                        case 0:
                            CertificateFrontView(size: geo.size.width * 0.6)
                        case 1:
                            CertificateBackView(size: geo.size.width * 0.6,userName: data.userName)
                        default:
                            CertificateFrontView(size: geo.size.width * 0.6)
                        }
                        
                        
                        
                        
                        
                    } .scaleEffect(scale)
                    .padding()
                }
               
                .zIndex(-4)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .gesture(MagnificationGesture()
                         
                    .onChanged { value in
                        
                        let scaleChange = value - 1
                        let newScale =  min(max(lastScale + scaleChange, 0.35), 1.5)
                        
                        
                        
                        self.scale = newScale
                        
                    }
                         
                    .onEnded({ value in
                        
                        
                        lastScale = scale
                        
                        
                    }))
            }
            
        }
        .modifier(MacBackgroundStyle(size:.init(width:size.width / 1.3,height: size.height / 1.5), title: "Certificate", movable: true,swipe: {
            swipe?()
        },close:{
            close?()
        }))
        .fileExporter(isPresented: $showFileExport, documents: docToSave.0, contentType: docToSave.1) { result in
            self.downloading = false
            
        }
       
    }
    func downloadCertificates(){
        self.downloading = true
        var images:[UIImage] = []
        let screen = size
        let canvasRatio = 1.0
        let canvasHeight = max(0, min( screen.height / 2.0, (screen.width - 120) * canvasRatio))
        let canvasWidth = max(0, canvasHeight / canvasRatio)
        let canvasSize = CGSize(width: canvasWidth, height: canvasHeight)
        let scale = makeMoreThan(value: 1024 / canvasWidth,needed: 4)
        
        
        let frontView = ZStack{
            CertificateFrontView(size: canvasSize.height)
                
               
            
        }.scaledToFill().clipped()
        
        
        let renderer = ImageRenderer(content:frontView)
        
        renderer.scale = scale
        
        if let frontImage = renderer.uiImage{
            images.append(frontImage)
          
        }
        let backView = ZStack{
            CertificateBackView(size: canvasSize.height,userName: self.data.userName)
                
               
            
        }.scaledToFill().clipped()
        
        
        let renderer2 = ImageRenderer(content:backView)
        
        renderer2.scale = scale
        
        if let backImage = renderer2.uiImage{
            images.append(backImage)
          
        }
        
        self.docToSave.0 = [ImageDocument(image:images)]
        self.docToSave.1 = .png
        
        self.showFileExport = true

       
    }
    func makeMoreThan(value:CGFloat,needed:CGFloat)->CGFloat{
        var new = value
        while new < needed{
            new *= 2
        }
        return new
    }
}

#Preview {
    CertficicatePreviewView(size:UIScreen.main.bounds.size)
        .environmentObject(ProjectData())
}



struct ImageDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.folder,.png,.jpeg] }
    var nameOfProject:String = "Chiphre Master Certificate"
  var images: [UIImage]
   
    init(nameOfProject:String = "Chiphre Master Certificate",image: [UIImage]) {
        self.nameOfProject = nameOfProject
    self.images = image
       
  }
  init(configuration: ReadConfiguration) throws {
      self.images = []
      if let wrappers = configuration.file.fileWrappers {
          for wrapper in wrappers{
              guard let data = wrapper.value.regularFileContents,
                  let image = UIImage(data: data)
            else {
              throw CocoaError(.fileReadCorruptFile)
            }
              self.images.append(image)
          }
      }
      
  }
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
            let folderWrapper = FileWrapper(directoryWithFileWrappers: [:])
        let fileName = ".png"
        for  id in images.indices {
               let image = images[id]
                let fileData = image.pngData()

                let fileWrapper = FileWrapper(regularFileWithContents: fileData ?? Data())
                fileWrapper.preferredFilename = "Certificate \(id + 1)" + fileName
                
                folderWrapper.addFileWrapper(fileWrapper)
                
                
            }
        folderWrapper.preferredFilename = "\(nameOfProject)" + " " + String(UUID().uuidString.prefix(4))
            return folderWrapper
        }
}
