//
//  Searchbar.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 10/10/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.theme.secondaryText)
        
            TextField("Search name or Symbol", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true)
                .overlay (
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .padding()
                        .offset(x: 10.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
            
        }.font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius:25)
                    .fill(Color.theme.background)
                    .shadow(
                        color: Color.theme.accent.opacity(0.15), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/,x: 0,y: 0
                    )
            )
            .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
