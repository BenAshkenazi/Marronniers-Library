//
//  ContentView.swift
//  Marrioners-0.7
//
//  Created by Ben Ashkenazi on 10/22/21.
//
import SwiftUI
import SafariServices
import UIKit


struct LinkButton{
    var id: Int
    var title: String?
    var link: String?
}

var myLinks=[
    LinkButton(id: 1, title: "About the Library", link: "https://tinyurl.com/aboutmarronniers"),
   LinkButton(id: 2, title: "Resources Online", link: "https://tinyurl.com/sourcesenligne"),
   LinkButton(id: 3, title: "Latest News", link: "https://tinyurl.com/newsactualities"),
   LinkButton(id: 4, title: "Catalogue", link: "https://tinyurl.com/cataloguelibrary"),
   LinkButton(id: 5, title: "Library Website", link: "https://tinyurl.com/siteweblibrary"),
   LinkButton(id: 6, title: "Games & Jeux", link: "https://tinyurl.com/gamesjeux"),
   
]





struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    @State var isLoading = true
    var body: some View {
            VStack {
                if isLoading {
                    LoadingView()
                } else {
                    DoneLoadingView()
                }
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isLoading = false
                }
            }
        }
    
}
        
struct LoadingView: View {
    var body: some View {
        ProgressView()
    }
}

struct DoneLoadingView: View {
    var body: some View {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear

        
        return NavigationView{
                    VStack {
                        Text("Marronniers Library").foregroundColor(Color.black).padding(.all).font(Font.largeTitle.weight(.bold)).background(Color(red:0.0,green:191.0, blue: 255.0)).opacity(0.97).cornerRadius(15)
                           
                        List {
                            ForEach(0..<6){index in
                                NavigationLink(destination: LinkView(linkButton:  myLinks[index])) {
                                    Text(myLinks[index].title!).foregroundColor(Color.black).font(Font.headline.weight(.bold))
                                }.listRowBackground(Color(red:0.0,green:191.0, blue: 255.0)).cornerRadius(15)
                                }
                            NavigationLink(destination:
                            ScannerView()) {
                                Text("Qr Scanner")
                            }.listRowBackground(Color(red:0.0,green:191.0, blue: 255.0)).font(Font.headline.weight(.bold)).foregroundColor(Color.black)
                                                         
                            
                        }
                    }.opacity(0.90)
                    .padding(.horizontal)
                    .background(Image("alt-home").resizable(resizingMode: .stretch).aspectRatio(UIImage(named: "alt-home")!.size, contentMode: .fill).edgesIgnoringSafeArea(.all)

)
                    
        }.navigationViewStyle(StackNavigationViewStyle())
                
                
    }
}
    
    




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*QrCodeScannerView()
 .found(r: ScannerView().viewModel.onFoundQrCode)
 .torchLight(isOn: ScannerView().viewModel.torchIsOn)
 .interval(delay: ScannerView().viewModel.scanInterval)*/
