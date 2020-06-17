//
//  ContentView.swift
//  RecipeBook
//
//  Created by George Davis IV on 6/16/20.
//  Copyright © 2020 3DMations. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Home ()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    var body: some View {
        
        ZStack {
            Color("Color").edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    HStack {
                        Button(action: {
                            
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                .font(.system(size: 30))
                                .padding(9)
                        }
                        .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .cornerRadius(10)
                        
                            Spacer ()
                        
                            Image("profileA")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    Text("Recipe Book")
                        .font(.system(size: 22))
                }
                
                Spacer()
                
            }
            .padding(.vertical)
        }
    }
}
