import SwiftUI

@main
struct MyApp: App {
    @StateObject var projectData:ProjectData = ProjectData()
    @StateObject var level4Data:Level4Data = Level4Data()
    @StateObject var level3Data:Level3Data = Level3Data()
    @StateObject var level2Data:Level2Data = Level2Data()
    @StateObject var level1Data:Level1Data = Level1Data()
   
    var body: some Scene {
        WindowGroup {
           
                ZStack{
                    StartView()
                        .preferredColorScheme(.dark)
                        .environmentObject(projectData)
                        .environmentObject(level4Data)
                        .environmentObject(level3Data)
                        .environmentObject(level2Data)
                        .environmentObject(level1Data)
                }
                    
            
            
        }
      
    }
}
