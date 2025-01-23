//
//  HomeView.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 25/08/24.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio: Bool = false
    @State private var addPortfolioView: Bool = false
    @EnvironmentObject var vm: HomeViewModel
    
    
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            VStack{
                homeHeader
                HomeStatisticView(showportfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                columnTitle
                if !showPortfolio{
                    allCoinList
                        .transition(.move(edge: .leading))
                        
                }
                if showPortfolio{
                    portfolioList
                        .transition(.move(edge: .trailing))
                        
                }

            }
           
        }
    }
}

#Preview {
    NavigationView{
        HomeView().navigationBarHidden(true)
    }
    .environmentObject(MockCoin.instance.homeVM)
    
}


extension HomeView {
    private var homeHeader: some View {
        ZStack{
            VStack {
                HStack {
                    CircleButtonView(iconName: showPortfolio ? "plus":"info")
                        .animation(.none, value:0)
                        .background(
                        CircleButtonAnimation(animate: $showPortfolio)
                        )
                        .onTapGesture {
                            addPortfolioView = true
                        }
                        .sheet(isPresented: $addPortfolioView, content: {
                            PortfolioView()
                                .environmentObject(vm)
                        })
                    Spacer()
                    Text(showPortfolio ? "Portfolio": "Live Prices")
                         .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.theme.accent)
                        .animation(.none)
                    Spacer()
                    CircleButtonView(iconName: "chevron.right")
                        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                        .onTapGesture {
                            withAnimation(.spring()) {
                                showPortfolio.toggle()
                            }
                        }
                }
                Spacer(minLength: 0)
            }
        }.frame(height: 70)
    }
    
    private var allCoinList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }.listStyle(.plain)
    }
    private var portfolioList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }.listStyle(.plain)
    }
    private var columnTitle: some View {
        HStack{
            Text("Coin")
            Spacer()
            if showPortfolio{
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            
        }.font(.caption)
            .foregroundColor(Color.theme.secondaryText)
            .padding(.horizontal)
    }
    
}

