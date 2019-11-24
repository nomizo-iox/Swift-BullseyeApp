//
//  ContentView.swift
//  bullsEye
//
//  Created by Samuel F. Ademola on 10/28/19.
//  Copyright © 2019 Nomizo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    /* STATE VARIABLES */
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    /* METHODS */
    func sliderValueRounded() -> Int {
        return Int(self.sliderValue.rounded())
    }
    
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let difference = amountOf()
        let bonus: Int
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        return maximumScore - difference + bonus
    }
    
    func amountOf() -> Int {
       return abs(self.target - sliderValueRounded())
    }
    
    func alertValue() -> String {
        let difference = amountOf()
        let title: String
        
        if difference == 0 {
            title = "Perfect."
        } else if difference < 5 {
            title = "You almost had it."
        } else if difference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
    
    func startNewGame() {
        score = 0
        round = 1
        sliderValue = 50.0
        target = Int.random(in: 1...100)
    }
    
    var body: some View {
        VStack {
            Spacer()
            // TARGET ROW
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("\(self.target)")
            }
            Spacer()
            
            // SLIDER ROW
            HStack{
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100")
            }
            Spacer()
            
            // BUTTON ROW
            Button(action: {
                print("Button Pressed")
                //  @State var alertIsVisible: Bool = false
                self.alertIsVisible = true
                
            }) {
                Text("Hit Me")
            }
            // Alert pop-up
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text(alertValue()),
                             message: Text("The slider's value is \(sliderValueRounded()).\n" + "You scored \(self.pointsForCurrentRound()) points this round."),
                             dismissButton: .default(Text("Awesome!")) {
                                
                                // Score will not update until the dismiss button is tapped
                                self.score = self.score + self.pointsForCurrentRound()
                                self.target = Int.random(in: 1...100)
                                self.round += 1
                    })
            }
            Spacer()
         
            // SCORE ROW
            HStack {
                Button(action: {
                    self.startNewGame()
                }) {
                    Text("Start Over")
                }
                Spacer()
                Text("Score:")
                Text("\(self.score)")
                Spacer()
                Text("Round:")
                Text("\(self.round)")
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Info")
                }
            }
            .padding(.bottom, 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
