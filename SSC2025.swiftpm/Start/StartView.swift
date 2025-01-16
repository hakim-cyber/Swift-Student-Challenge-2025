import SwiftUI

struct StartView: View {
    @EnvironmentObject var data:ProjectData
    @State private var uiscreen = UIScreen.main.bounds
    @State private var finished = false
    var body: some View {
        ZStack{
            switch data.startSteps {
            case .helloView:
                HelloView{
                    withAnimation{
                        data.startSteps = .nameView
                    }
                }
                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
            case .nameView:
                NameView{
                    withAnimation{
                        self.data.startSteps = .desktopView
                    }
                }
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .top)))
                   
            case .desktopView:
                DesktopView()
            }
            
        }
        
       
        
    }
}
