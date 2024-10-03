//
//  DeCentralizeApp.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 24/08/24.
//

import SwiftUI

@main
struct DeCentralizeApp: App {
    @StateObject var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView().navigationBarHidden(true)
            }
            .environmentObject(vm)
            
        }
    }
}
