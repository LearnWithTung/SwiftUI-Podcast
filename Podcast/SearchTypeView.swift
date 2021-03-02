//
//  SearchTypeView.swift
//  Podcast
//
//  Created by Tung Vu Duc on 02/03/2021.
//

import SwiftUI

struct SearchTypeView: View {
    let type: SearchType
    var selected: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Circle()
                .fill(selected ? Color("selected") : Color("semidark"))
                .overlay(
                    Image(systemName: type.systemImageName)
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(selected ? .white : .gray)
                )
            
            Text(type.name)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(selected ? .white : Color("gray"))
        }
    }
}
