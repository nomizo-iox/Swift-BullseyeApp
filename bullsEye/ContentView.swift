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
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    
    var body: some View {
        VStack {
            Spacer()
            // TARGET ROW
            HStack {
                Text("Put the bullseye as close asn you can too:")
                Text("100")
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
                let roundedValue: Int = Int(self.sliderValue.rounded())
                return Alert(title: Text("Hello There!"), message: Text("The slider's value is \(roundedValue)"), dismissButton: .default(Text("Awesome!")))
            }
            Spacer()
         
            // SCORE ROW
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Start Over")
                }
                Spacer()
                Text("Score:")
                Text("99999")
                Spacer()
                Text("Round:")
                Text("999")
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
