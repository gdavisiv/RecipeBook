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
    
    @State var menu = 0
    @State var page = 0
    
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
                        //.background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).opacity(0.1))
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
                
                HStack(spacing: 15) {
                    
                    Button(action: {
                        self.menu = 0
                        
                    }) {
                        
                        Text("Soul Food")
                            .foregroundColor(self.menu == 0 ? .white : .black)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                        
                    }
                    .background(self.menu == 0 ? Color.black : Color.white)
                    .clipShape(Capsule())
                    
                    Button(action: {
                        self.menu = 1
                        
                    }) {
                        
                        Text("Spanish")
                            .foregroundColor(self.menu == 1 ? .white : .black)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                        
                    }
                    .background(self.menu == 1 ? Color.black : Color.white)
                    .clipShape(Capsule())
                    
                    Button(action: {
                        self.menu = 2
                        
                    }) {
                        
                        Text("Italian")
                            .foregroundColor(self.menu == 2 ? .white : .black)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                        
                    }
                    .background(self.menu == 2 ? Color.black : Color.white)
                    .clipShape(Capsule())
                    
                }
                .padding(.top, 30)
                
                GeometryReader {g in
                    
                    //List()
                    Carousel(width: UIScreen.main.bounds.width, height: g.frame(in: .global).height, page: self.$page)
                    
                }
                
            }
            .padding(.vertical)
        }
    }
}

struct List : View {
    
    @Binding var page : Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(data) { i in
                Card(page: self.$page, width: UIScreen.main.bounds.width, data: i)
            }
        }
    }
}

struct Card : View {
    
    @Binding var page : Int
    var width : CGFloat
    var data : Type
    
    var body: some View {
        VStack {
            VStack {
                Text(self.data.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Text(self.data.cName)
                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                    .padding(.vertical)
                
                Spacer(minLength: 0)
                
                Image(self.data.image)
                    .resizable()
                    .frame(width: self.width - (self.page == self.data.id ? 100 : 100), height: (self.page == self.data.id ? 250 : 200))
                    .cornerRadius(20)
                
                Text(self.data.ingredients)
                    .fontWeight(.light)
                    .font(.caption)
                    .padding(.top, 20)
                
                Button(action: {
                    
                }) {
                    Text("Save")
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                }
                .background(Color("Color"))
                .clipShape(Capsule())
                .padding(.top, 20)
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 25)
            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .cornerRadius(20)
            .padding(.top, 25)
            .padding(.vertical, self.page == data.id ? 0 : 25)
            .padding(.horizontal, self.page == data.id ? 0 : 25)
        }
        .frame(width: self.width)
        .animation(.default)
    }
}

struct Carousel : UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return Carousel.Coordinator(parent1: self)
    }
    
    
    var width : CGFloat
    var height : CGFloat
    @Binding var page : Int

    
    func makeUIView(context: Context) -> UIScrollView {
        
        let total = width * CGFloat(data.count)
        let view = UIScrollView()
        view.isPagingEnabled = true
        //Use 1.0 for disabiling Vertical Scrolling
        view.contentSize = CGSize(width: total , height: 1.0)
        view.bounces = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = context.coordinator
        
        let view1 = UIHostingController(rootView: List(page: self.$page))
        view1.view.frame = CGRect(x: 0, y: 0, width: total, height: self.height)
        
        view1.view.backgroundColor = .clear
        
        view.addSubview(view1.view)
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
    class Coordinator : NSObject, UIScrollViewDelegate {
        
        var parent : Carousel
        init(parent1: Carousel) {
            
            parent = parent1
        }
        //Use this function for getting the current page
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let page = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
            
            //print(page)
            //Loot at Debug and it will show the slide number
            self.parent.page = page
        }
    }
    
}

struct PageControl : UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        <#code#>
    }
    
    
}


struct Type : Identifiable {
    var id : Int
    var name : String
    var cName : String
    var ingredients : String
    var image : String
}

var data = [
    Type(id: 0, name: "Quinoa", cName: "Soul Food", ingredients: "Quinoa, White Rice, salt, pepper, etc", image: "Quinoa"),
    Type(id: 1, name: "Chickpeas", cName: "Soul Food", ingredients: "Steak, salt, pepper, etc", image: "Chickpeas"),
    Type(id: 2, name: "Rice", cName: "Soul Food", ingredients: "Steak, salt, pepper, etc", image: "Rice"),
    Type(id: 3, name: "Salmon", cName: "Soul Food", ingredients: "Salmon, salt, pepper, etc", image: "Salmon"),
    Type(id: 4, name: "Vegetable Dish", cName: "Spanish", ingredients: "Carrots, Tomatoes, Brussel Sprouts, etc", image: "Veggies"),
    Type(id: 5, name: "Brownies", cName: "Soul Food", ingredients: "Carrots, Tomatoes, Brussel Sprouts, etc", image: "Brownies"),
    Type(id: 6, name: "Grilled Dish", cName: "Italian", ingredients: "Carrots, Tomatoes, Brussel Sprouts, etc", image: "Grilled")]
