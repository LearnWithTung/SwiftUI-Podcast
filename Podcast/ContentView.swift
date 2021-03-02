//
//  ContentView.swift
//  Podcast
//
//  Created by Tung Vu Duc on 02/03/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
    @State private var selected: SearchType = types[0]
    @State private var headerMaxY: CGFloat = 0
    @State private var collapse: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image("logo")
                
                Text("pcast")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                
                Spacer()
                
                HStack(spacing: 40) {
                    if collapse {
                        Button(action: {}, label: {
                            Text(searchText)
                                .font(.footnote)
                                .foregroundColor(.white)
                            
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 23, weight: .medium))
                        })
                    }
                    
                    Button(action: {}, label: {
                        Image(systemName: "line.horizontal.3")
                    })
                }
            }
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(Color("background"))
            .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0.0, y: 0.0)
            .overlay(
                GeometryReader{proxy -> Color in
                    DispatchQueue.main.async {
                        if headerMaxY == 0 {
                            headerMaxY = proxy.frame(in: .global).maxY
                            print(headerMaxY)
                        }
                    }
                    return Color.clear
                }
            )
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Browse")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal, 26)
                        .padding(.top, 30)
                    
                    HStack {
                        ZStack(alignment: .leading) {
                            TextField("", text: $searchText)
                            
                            if searchText.isEmpty {
                                Text("Search...")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 20))
                        })
                    }
                    .foregroundColor(.white)
                    .padding(18)
                    .background(Color("dark"))
                    .cornerRadius(12)
                    .padding()
                    .padding([.top, .bottom], 20)
                    .overlay(
                        GeometryReader {proxy -> Color in
                            DispatchQueue.main.async {
                                withAnimation(.spring()) {
                                    if proxy.frame(in: .global).maxY - headerMaxY - 20 - 16 <= 0 {
                                        collapse = true
                                    } else {
                                        collapse = false
                                    }
                                }
                            }
                            return Color.clear
                        }
                    )
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(types, id:\.id) { type in
                                Button(action: {
                                    selected = type
                                }, label: {
                                    SearchTypeView(type: type, selected: selected == type ? true : false)
                                        .frame(width: 65, height: 90)
                                        .padding(.horizontal)
                                })
                            }
                        }
                    }
                    
                    Text("\(selected.name) (3)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("gray"))
                        .padding()
                        .padding([.top, .bottom], 30)
                        .padding(.top, 20)
                    
                    ForEach(authors, id: \.id) {author in
                        VStack {
                            ZStack(alignment: .bottomLeading, content: {
                                author.bgColor
                                    .frame(height: 130)
                                    .clipShape(Curves())
                                
                                HStack(alignment: .center, spacing: 0) {
                                    Image(author.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 200)
                                        .padding(.horizontal)
                                    
                                    VStack(alignment: .leading, spacing: 10, content: {
                                        Text(author.name)
                                            .font(.system(size: 22, weight: .bold, design: .rounded))
                                        
                                        Text("Podcasts: \(author.podcasts)")
                                            .font(.footnote)
                                            .fontWeight(.bold)
                                    })
                                    .offset(y: 30)
                                }
                                .foregroundColor(.white)
                            })
                            .overlay(
                                LinearGradient(gradient: Gradient(colors: [Color.clear, author.bgColor]), startPoint: .center, endPoint: .bottom)
                                    .clipShape(Curves())
                            )
                        }
                        .frame(height: 165)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom)
                }
            }
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color("background").ignoresSafeArea())
    }
}

struct Curves: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .topLeft, .topRight], cornerRadii: .init(width: 30, height: 30))
        
        return Path(path.cgPath)
    }
}

struct SearchType: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let systemImageName: String
}

let types = [
    SearchType(name: "Categories", systemImageName: "play.circle"),
    SearchType(name: "Topics", systemImageName: "network"),
    SearchType(name: "Authors", systemImageName: "face.smiling"),
    SearchType(name: "Podcasts", systemImageName: "mic"),
    SearchType(name: "Episodes", systemImageName: "music.quarternote.3"),
]

struct Author {
    let id = UUID()
    let name: String
    let imageName: String
    let podcasts: String
    let bgColor: Color
}

let authors = [
    Author(name: "Robert Dugoni", imageName: "a1", podcasts: "7.286", bgColor: Color("a1bg")),
    Author(name: "J.K. Rowling", imageName: "a2", podcasts: "7.286", bgColor: Color("a2bg")),
    Author(name: "Mary Beth Keane", imageName: "a3", podcasts: "7.286", bgColor: Color("a3bg")),
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
