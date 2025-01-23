//
//  PortfolioView.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 11/11/24.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm :HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .background(
                Color.theme.background
                    .ignoresSafeArea()
            )
            .navigationTitle("Edit Portfolio")
            .toolbar (content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButton
                }
            }).onChange(of: vm.searchText, perform: { value in
                if value == "" {
                    unselectCoin()
                }
            })
                        
           

        }
    }
}
extension PortfolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing:10) {
                ForEach(vm.allCoins) { coin in
                    CoinCardView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation {
                                if let selectedCoin = selectedCoin, selectedCoin.id == coin.id {
                                  unselectCoin()
                                } else {
                                  selectedCoin = coin
                                }
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                        )
                }
            }
        })
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "")")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith2To6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount of \(selectedCoin?.symbol.uppercased() ?? "")")
                Spacer()
                TextField("Eg: 2.3", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current Value")
                Spacer()
                  Text(getCurrentValueOfSelectedCoin().asCurrencyWith2Decimals())
            }
        }
        .animation(.none, value: UUID())
        .padding()
        .font(.headline)
    }
    private var trailingNavBarButton: some View {
        HStack {
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            Button {
               saveButtonPressed()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(
                (selectedCoin != nil && (selectedCoin?.currentHoldings != Double(quantityText) || Double(quantityText) == 0.0) ? 1.0 : 0.0)
            )
        }
        .font(.headline)
    }
    
    private func getCurrentValueOfSelectedCoin() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        
        // save to portfolio
//        vm.updatePorfolio(coin: coin, amount: amount)
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckMark = true
            unselectCoin()
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        }
    }
    
    private func unselectCoin() {
        selectedCoin = nil
        vm.searchText = ""
        quantityText = ""
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }), let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
}
#Preview {
    PortfolioView()
}
