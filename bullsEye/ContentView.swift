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
    
    let midnightBlue = Color(red: 25.0/250.0, green: 51.0/255.0, blue: 102.0/255.0)
    
    /* VIEW MODIFIERS*/
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View{
            return content
            .foregroundColor(Color.yellow)
            .modifier(Shadow())
            .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct ButtonLargeTetStyle: ViewModifier {
          func body(content: Content) -> some View{
              return content
              .foregroundColor(Color.black)
              .font(Font.custom("Arial Rounded MT Bold", size: 18))
          }
      }
    
    struct ButtonSmallTetStyle: ViewModifier {
           func body(content: Content) -> some View{
               return content
               .foregroundColor(Color.black)
               .font(Font.custom("Arial Rounded MT Bold", size: 12))
           }
       }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View{
            return content
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
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
                Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
                Text("\(self.target)").modifier(ValueStyle())
            }
            Spacer()
            
            // SLIDER ROW
            HStack{
                Text("1").modifier(LabelStyle())
                Slider(value: self.$sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            Spacer()
            
            // BUTTON ROW
            Button(action: {
                print("Button Pressed")
                //  @State var alertIsVisible: Bool = false
                self.alertIsVisible = true
                
            }) {
                Text("Hit Me").modifier(ButtonLargeTetStyle())
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
            .background(Image("Button")).modifier(Shadow())
            Spacer()
         
            // SCORE ROW
            HStack {
                Button(action: {
                    self.startNewGame()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start Over").modifier(ButtonSmallTetStyle())
                    }
                }
                .background(Image("Button")).modifier(Shadow())
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(self.score)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(self.round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTetStyle())
                    }
                }
                .background(Image("Button")).modifier(Shadow())
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
        .navigationBarTitle("Bullseye")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
