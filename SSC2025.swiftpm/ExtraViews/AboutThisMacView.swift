//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/16/25.
//

import SwiftUI

struct AboutThisMacView: View {
  
    var body: some View {
            VStack(spacing: 16) {
                
                Image(systemName: "macbook.gen2")
                    .resizable()
                    .scaledToFit()
                   
                    .padding(.horizontal,40)
                    .foregroundColor(Color.blue)

               
                VStack(spacing: 4) {
                    Text("MacBook Pro")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("14-inch, 2024")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }

               
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Chip")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("Apple M4 Pro")
                    }
                    HStack {
                        Text("Memory")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("24 GB")
                    }
                    HStack {
                        Text("Serial number")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("-------")
                    }
                    HStack {
                        Text("macOS")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("Sequoia 15.2")
                    }
                }
                .font(.callout)
                .padding()
                .background(Color(uiColor: .systemGray6))
                .cornerRadius(12)

               
                Button(action: {}) {
                    Text("More Info...")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .padding(5)
                        .padding(.horizontal,10)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .fixedSize()
                }

                
                Text("Regulatory Certification\n™ and © 1983–2024 Apple Inc.\nAll Rights Reserved.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .frame(maxWidth: 300)
           
            .foregroundColor(.white)
            .cornerRadius(16)
            .shadow(radius: 10)
        }
}

#Preview {
    let sizeofScreen = UIScreen.main.bounds
    AboutThisMacView()
        .modifier(MacBackgroundStyle(size: .init(width: sizeofScreen.width / 4, height: sizeofScreen.height / 1.7), close: {
            
        }))
}
