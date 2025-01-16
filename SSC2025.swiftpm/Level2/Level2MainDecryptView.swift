//
//  SwiftUIView.swift
//  SSC2025
//
//  Created by aplle on 1/7/25.
//

import SwiftUI

struct Level2MainDecryptView: View {
    let size:CGSize
    @State var progress = 0.0
    @State var characters:[CharacterStruct] = characters_
    @State var correctcharacters:[CharacterStruct] = correctCharactersOrder
    
    @State var shuffledRows:[[CharacterStruct]] = []
    
    @State var rows:[[CharacterStruct]] = []
    
    @State private var animateWrongText = false
    @State private var showHint = false
    
    @State private var draggingCharacter:CharacterStruct?
    
    @State private var droppedCount = 0.0
    
    @StateObject var morseSoundManager = MorseCodeConverter()
    
    @Binding var showInstructions:Bool
    
    var body: some View {
        VStack(spacing: 35) {
           
            Spacer()
            VStack(spacing: 35) {
                if !showInstructions{
                    HStack{
                        VStack(alignment: .leading, spacing: 20){
                            Text("Decrypt The Morse Code")
                                .fontWeight(.black)
                                .fontDesign(.monospaced)
                                .font(.system(size:20))
                            HStack{
                                Image("robot")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .padding(.leading,10)
                                VStack(alignment: .leading){
                                    morseCodeText()
                                    Spacer()
                                    HStack(spacing: 20){
                                        HStack(alignment:.lastTextBaseline, spacing: 0){
                                            Image(systemName: "lightbulb.max.fill")
                                                .font(.system(size: 18))
                                                .foregroundStyle(.yellow)
                                            Text("Hints")
                                                .bold()
                                                .font(.system(size: 18))
                                        }
                                        Toggle("", isOn: $showHint)
                                            .labelsHidden()
                                            .tint(.yellow)
                                        
                                        Spacer()
                                    }
                                    
                                }
                                
                                
                            }
                        }
                        Spacer()
                    }
                    VStack(spacing:30){
                        rectangleWithProgress()
                        DropArrea()
                        
                        
                        rectangleWithProgress()
                        
                    }
                    DragArea()
                }else{
                    instructionsView()
                }
                
            }
            .frame(maxWidth: .infinity) // Ensure it doesn't exceed the screen width
            .fixedSize(horizontal: false, vertical: true) // Allow vertical expansion if needed
            .padding(40)
            Spacer()
        }
        .padding()
        .frame(width: size.width,height: size.height)
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
        .offset(x:animateWrongText ? 10 : 0)
        .onAppear{
            if rows.isEmpty{
                characters = characters.shuffled()
                shuffledRows = generateGrid()
               
                rows = generateCorrectGrid()
            }
        }
        
    }
    
    
    let morseCodeAlphabet: [String: String] = [
        "A": ".-", "B": "-...", "C": "-.-.", "D": "-..", "E": ".",
        "F": "..-.", "G": "--.", "H": "....", "I": "..", "J": ".---",
        "K": "-.-", "L": ".-..", "M": "--", "N": "-.", "O": "---",
        "P": ".--.", "Q": "--.-", "R": ".-.", "S": "...", "T": "-",
        "U": "..-", "V": "...-", "W": ".--", "X": "-..-", "Y": "-.--",
        "Z": "--..", "0": "-----", "1": ".----", "2": "..---",
        "3": "...--", "4": "....-", "5": ".....", "6": "-....",
        "7": "--...", "8": "---..", "9": "----.", " ": " " // Space between words
    ]

    
    @ViewBuilder
    func draggableLetter(character:CharacterStruct)->some View{
        
        let show = character.isShowing
       
        VStack{
            Text(character.value)
            Divider()
            
            Text(morseCodeAlphabet[character.value]!)
        }
        .font(.system(size: character.fontSize))
        .bold()
        .fixedSize()
        .padding(.vertical,5)
        .padding(.horizontal,character.padding)
        
        .background(
            RoundedRectangle(cornerRadius: 6).stroke(.white,lineWidth: 2)
              
        )
        .contentShape(Rectangle())
        .onDrag {
            self.draggingCharacter = character
            return NSItemProvider(object: character.value as NSString)
        }
        .opacity(show ? 0:1)
        .background(RoundedRectangle(cornerRadius: 6).fill(!show ? .clear:.init(uiColor: .systemGray5)))
        
        
    }
    @ViewBuilder
    func dropableLetter(character:CharacterStruct)->some View{
        
        let show = character.isShowing
        let hint = showHint && character.value == draggingCharacter?.value
        VStack{
            Text(character.value)
            Divider()
            
            Text(morseCodeAlphabet[character.value]!)
        }
        .font(.system(size: character.fontSize))
        .bold()
        .fixedSize()
        .padding(.vertical,5)
        .padding(.horizontal,character.padding)
        
        .opacity(show ? 1:0)
        .background(RoundedRectangle(cornerRadius: 6).fill(show ? .clear: hint ? .green: .init(uiColor: .systemGray5)))
        .contentShape(Rectangle())
        .background(
            RoundedRectangle(cornerRadius: 6).stroke(.white,lineWidth: 3)
                .opacity(show ? 1:0)
        )
        .onDrop(of: [.plainText], isTargeted: .constant(false)) { providers in
            if let first = providers.first {
                let _ = first.loadObject(ofClass: String.self) { value, error in
                    guard let droppedString = value else { return }
                    
                    print("Dropped String: \(droppedString)")
                    print("Character ID: \(character.id)")
                    
                    if character.value == droppedString {
                        // Correct match: Update arrays
                        self.updateArraysAfterDrop(character: character)
                    } else {
                        // Incorrect match: Animate view
                        self.animateView()
                    }
                    
                    // Reset dragging character
                    self.draggingCharacter = nil
                }
            }
            return true
        }
        
        
    }
    @ViewBuilder
    func DragArea()->some View{
        VStack(spacing: 12){
            ForEach(shuffledRows,id:\.self){row in
                HStack(spacing: 10){
                    ForEach(row){item in
                        draggableLetter(character:item)
                            
                    }
                }
               
            }
          
        }
    }
    @ViewBuilder
    func DropArrea()->some View{
        VStack(spacing: 12){
            ForEach($rows,id:\.self){$row in
                HStack(spacing: 10){
                    ForEach($row){$item in
                        dropableLetter(character:item )
                           
                    }
                }
            }
        }
    }
    func generateGrid()->[[CharacterStruct]]{
        for item in characters.enumerated(){
            let textSize = textSize(character: item.element)
            characters[item.offset].textSize = textSize
        }
        var gridArray:[[CharacterStruct]] = []
        var tempArray:[CharacterStruct] = []
        
        var currentWidth:CGFloat = .zero
        let totalScreenWidth = size.width - 30
        
        for character in characters{
            currentWidth += character.textSize
            
            if currentWidth < totalScreenWidth{
                tempArray.append(character)
            }else{
                gridArray.append(tempArray)
                tempArray = []
                currentWidth = character.textSize
                tempArray.append(character)
            }
        }
        if !tempArray.isEmpty{
            gridArray.append(tempArray)
        }
        return gridArray
    }
    
    func generateCorrectGrid()->[[CharacterStruct]]{
        for item in correctcharacters.enumerated(){
            let textSize = textSize(character: item.element)
            correctcharacters[item.offset].textSize = textSize
        }
        var gridArray:[[CharacterStruct]] = []
        var tempArray:[CharacterStruct] = []
        
        var currentWidth:CGFloat = .zero
        let totalScreenWidth = size.width - 30
        
        for character in correctcharacters{
            currentWidth += character.textSize
            
            if currentWidth < totalScreenWidth{
                tempArray.append(character)
            }else{
                gridArray.append(tempArray)
                tempArray = []
                currentWidth = character.textSize
                tempArray.append(character)
            }
        }
        if !tempArray.isEmpty{
            gridArray.append(tempArray)
        }
        return gridArray
    }
    
    func textSize(character:CharacterStruct)->CGFloat{
        let morscode = morseCodeAlphabet[character.value]!
        
        let font = UIFont.systemFont(ofSize: character.fontSize)
        let attributes = [NSAttributedString.Key.font:font]
        
        
        let size = (character.value as NSString).size(withAttributes: attributes)
        let morscodeSize = (morscode as NSString).size(withAttributes: attributes)
        if size.width >= morscodeSize.width{
            return size.width + (character.padding * 2) + 15
        }else{
            return morscodeSize.width + (character.padding * 2) + 15
        }
    }
    func updateArraysAfterDrop(character:CharacterStruct){
        for index in rows.indices{
            for subIndex in rows[index].indices{
                if rows[index][subIndex].value == character.value{
                    droppedCount += 1
                    let progress = (droppedCount / CGFloat(correctCharactersOrder.count))
                    rows[index][subIndex].isShowing = true
                    self.progress = progress
                    if progress == 1{
                        
                            withAnimation(.easeInOut){
                                DispatchQueue.main.async {
                                    self.showInstructions = true
                                }
                              
                            }
                        
                    }
                    
                }
            }
        }
        for index in shuffledRows.indices{
            for subIndex in shuffledRows[index].indices{
                if shuffledRows[index][subIndex].value == character.value{
                    shuffledRows[index][subIndex].isShowing = true
                }
            }
        }
    }
    func animateView(){
        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.2, blendDuration: 0.2)){
            animateWrongText = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.2, blendDuration: 0.2)){
                animateWrongText = false
            }
        }
    }
    
    func rectangleWithProgress()->some View{
        GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // Background Divider
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 4)

                        // Progress Bar
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: geometry.size.width * progress, height: 4)
                            .animation(.easeInOut, value: progress)
                    }
                }
    }
    @ViewBuilder
    func morseCodeText()->some View{
        HStack{
            if morseSoundManager.isPlaying{
                Image(systemName: "speaker.wave.3.fill")
                    .foregroundStyle(Color.cyan)
            }else{
                Image(systemName: "speaker.fill")
                    .foregroundStyle(Color.cyan)
            }
            Text("..- | ... | . | .-. | ... | ..-. | --- | .-.. | -.. | . | .-. ")
        }
            .font(.system(size: 18, weight:  .black, design: .monospaced))
                                       .foregroundStyle(Color.white)
                                       .lineSpacing(20)
                                       .multilineTextAlignment(.leading)
                                       .lineLimit(nil) // Allow unlimited lines
                                                       .fixedSize(horizontal: false, vertical: true)
                                       .padding()
                                   
                                       .clipShape(RoundedRectangle(cornerRadius: 10))
                                       .overlay{
                                           RoundedRectangle(cornerRadius: 10)
                                               .stroke(Color.cyan,lineWidth: 3)
                                       }
                                       .contentShape(Rectangle())
                                       .onTapGesture {
                                           // make sound of morse code
                                           soundofMorseCode()
                                       }
    }
    func soundofMorseCode(){
      
        morseSoundManager.playMorseCode("..- ... . .-. ... ..-. --- .-.. -.. . .-."){
            
        }
    }
    
    @ViewBuilder
    func instructionsView()->some View{
        
            VStack{
                VStack(alignment: .leading, spacing: 20) {
                           Text("🎉 Mission Success! 🎉")
                               .font(.largeTitle.bold())
                               .foregroundColor(.cyan)
                               .multilineTextAlignment(.center)
                    Group{
                        Text("You've decoded the word: ")
                            .font(.title2)
                            .foregroundColor(.white)
                        + Text(" 'USERS FOLDER'")
                            .font(.title2.bold())
                            .foregroundColor(.cyan)
                    }
                    .fontWeight(.black)
                           
                           Text("Here’s your next mission:")
                               .font(.headline)
                               .foregroundColor(.yellow)
                               .padding(.top)
                               .fontWeight(.black)
                           VStack(alignment: .leading, spacing: 10) {
                               HStack(alignment: .top) {
                                   Text("1.")
                                       
                                       .foregroundColor(.orange)
                                   Text("Close this window immediately to stay ahead of the hackers.")
                                       .foregroundColor(.white)
                                       
                               }
                               
                               HStack(alignment: .top) {
                                   Text("2.")
                                       
                                       .foregroundColor(.orange)
                                   Text("Navigate to the **Users Folder** on the desktop.")
                                       .foregroundColor(.white)
                                       
                               }
                               
                               HStack(alignment: .top) {
                                   Text("3.")
                                      
                                       .foregroundColor(.orange)
                                   Text("Inside the folder, locate the **attendee database file**.")
                                       .foregroundColor(.white)
                                       
                               }
                               
                               HStack(alignment: .top) {
                                   Text("4.")
                                       
                                       .foregroundColor(.orange)
                                   Text("Use the password from Level 1 (**5FC@WWDC**) to unlock the file.")
                                       .foregroundColor(.white)
                                       
                               }
                               
                               HStack(alignment: .top) {
                                   Text("5.")
                                       
                                       .foregroundColor(.orange)
                                   Text("Send the attendee database securely to Steve Jobs’ virtual assistant.")
                                       .foregroundColor(.white)
                                       
                               }
                           }
                           .padding(.leading, 10)
                           .fontWeight(.heavy)
                           .font(.system(size: 20))
                           Text("⚡ WWDC is counting on you—good luck, Cipher Master!")
                               .font(.title.bold())
                               .foregroundColor(.yellow)
                               .multilineTextAlignment(.center)
                               .padding(.top)
                               .particleEffect(systemImage: "star.fill", font: .largeTitle, status: showInstructions , activeTint: .yellow, inactiveTint: .secondary)
                       }
                       .padding()
                      
                       
            }
         
                .frame(width: size.width,height: size.height)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
            
        
    }
}

#Preview {
    Level2MainDecryptView(size: UIScreen.main.bounds.size, showInstructions: .constant(false))
}

struct CharacterStruct:Identifiable,Hashable,Equatable{
    var id = UUID().uuidString
    var value:String
    var padding:CGFloat = 10
    var textSize:CGFloat = .zero
    var fontSize:CGFloat = 19
    var isShowing:Bool = false
}

let characters_:[CharacterStruct] = [
    CharacterStruct(value: "B"),
    CharacterStruct(value: "E"),
    CharacterStruct(value: "R"),
    CharacterStruct(value: "S"),
    CharacterStruct(value: "U"),
    CharacterStruct(value: "A"),
    CharacterStruct(value: "S"),
    CharacterStruct(value: "F"),
    CharacterStruct(value: "O"),
    CharacterStruct(value: "L"),
    CharacterStruct(value: "D"),
    CharacterStruct(value: "E"),
    CharacterStruct(value: "R"),
    
]
let correctCharactersOrder:[CharacterStruct] = [
    CharacterStruct(value: "U"),
    CharacterStruct(value: "S"),
    CharacterStruct(value: "E"),
    CharacterStruct(value: "R"),
    CharacterStruct(value: "S"),
    CharacterStruct(value: "F"),
    CharacterStruct(value: "O"),
    CharacterStruct(value: "L"),
    CharacterStruct(value: "D"),
    CharacterStruct(value: "E"),
    CharacterStruct(value: "R"),
    
    
    ]
