//
//  AboutView.swift
//  bullsEye
//
//  Created by Samuel F. Ademola on 11/24/19.
//  Copyright © 2019 Nomizo. All rights reserved.
//

import SwiftUI

struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(Color.white)
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
    }
}


struct AboutView: View {
    var body: some View {
        VStack{
            Text("🎯 BullsEye 🎯").modifier(LabelStyle())
            Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider").modifier(LabelStyle())
            Text("Your goal is to place the slider as close as possible to the target value.  The closer you are, the more points you score").modifier(LabelStyle())
            Text("Enjoy!!").modifier(LabelStyle())
        }
        .background(Image("Background"), alignment: .center)
        .navigationBarTitle("About Bullsye")
    }
}
 
struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
