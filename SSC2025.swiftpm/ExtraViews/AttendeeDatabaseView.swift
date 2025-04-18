//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/17/25.
//

import SwiftUI
struct Attendee: Identifiable {
    var id = UUID()
    var name: String
    var role: String
    var company: String
    var email: String
}
let attendees = [
    Attendee(name: "Elon Musk", role: "CEO", company: "SpaceX", email: "elon@spacex.com"),
    Attendee(name: "Craig Federighi", role: "SVP of Software Engineering", company: "Apple", email: "craig@apple.com"),
    Attendee(name: "Tim Cook", role: "CEO", company: "Apple", email: "tim@apple.com"),
    Attendee(name: "Sundar Pichai", role: "CEO", company: "Google", email: "sundar@google.com"),
    Attendee(name: "Satya Nadella", role: "CEO", company: "Microsoft", email: "satya@microsoft.com"),
    Attendee(name: "Mark Zuckerberg", role: "CEO", company: "Meta", email: "mark@meta.com"),
    Attendee(name: "Sheryl Sandberg", role: "COO", company: "Meta", email: "sheryl@meta.com"),
    Attendee(name: "Jeff Bezos", role: "Founder", company: "Amazon", email: "jeff@amazon.com"),
    Attendee(name: "Bill Gates", role: "Co-Founder", company: "Microsoft", email: "bill@gates.com"),
    Attendee(name: "Steve Jobs", role: "Co-Founder", company: "Apple", email: "steve@apple.com"),
    Attendee(name: "Alice Wonderland", role: "CTO", company: "WonderTech", email: "alice@wondertech.com"),
    Attendee(name: "Bob Builder", role: "Lead Developer", company: "BuildCo", email: "bob@buildco.com"),
    Attendee(name: "Charlie Brown", role: "Product Manager", company: "TechBros", email: "charlie@techbros.com"),
    Attendee(name: "Diana Prince", role: "VP of Engineering", company: "Amazon", email: "diana@amazon.com"),
    Attendee(name: "Harry Potter", role: "Senior Software Engineer", company: "Magic Corp", email: "harry@magiccorp.com"),
    Attendee(name: "Clark Kent", role: "Journalist", company: "Daily Planet", email: "clark@dailyplanet.com")
]

struct AttendeeDatabaseView: View {
    let size: CGSize
    var swipe:(()->Void)?
    var close:(()->Void)?
        var body: some View {
            Table(attendees) {
                            TableColumn("Name", value: \.name)
                            TableColumn("Role", value: \.role)
                            TableColumn("Company", value: \.company)
                            TableColumn("Email", value: \.email)
            }.scrollContentBackground(.hidden)
                .modifier(MacBackgroundStyle(size:.init(width:size.width / 2,height: size.height / 1.2), movable: true,swipe: {
                    swipe?()
                },close:{
                    close?()
                }))
                       
        }
}

#Preview {
    let size = UIScreen.main.bounds.size
  return  AttendeeDatabaseView(size: size)
       
    
}
