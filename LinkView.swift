//
//  LinkView.swift
//  Marrioners-0.7
//
//  Created by Ben Ashkenazi on 10/22/21.
//

//
//  ContentView.swift
//  WKWebView
//
//  Created by Ben Ashkenazi on 10/22/21.
//
import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
}



class WebViewModel: ObservableObject {
    let webView: WKWebView
    var actualLink: URL?
    public var title: String?
    var linkButton: LinkButton
    var codeFound: Bool

    
    init(linkButton: LinkButton) {
        self.linkButton = linkButton
        webView = WKWebView(frame: .zero)
        title = linkButton.title
        if title != nil && linkButton.link != nil{
                if let x = linkButton.link,
                    let actualLink = URL(string: x){
                    
                    self.actualLink = actualLink
                }
                codeFound = true
                
        }else{
            codeFound = false
            title = "Code not found"
            actualLink = URL(string: "www.google.com")!
            
        }
        loadUrl()
    }

    func loadUrl() {
        if codeFound{
            if let actualLink = actualLink {
                webView.load(URLRequest(url: actualLink as URL))
            }
            
        }
    }
}

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button("Internet Connection Unavailable, please check your connection and try again.") {
            presentationMode.wrappedValue.dismiss()
        }
        .font(.title)
        .padding()
        .background(Color.black)
    }
}

struct LinkView: View {
    //let link: URL
    @State var linkButt: LinkButton
    @State var isLoading = true
    var model : WebViewModel//(link: link)
    init(linkButton: LinkButton) {
        //self.link = link
        linkButt=linkButton
        model=WebViewModel(linkButton: linkButton)
        
        //print(link.absoluteString)
    }
    
    var body: some View {
            VStack {
                if isLoading {
                    LoadingView()
                } else {
                    LinkDoneLoadingView(linkButton: linkButt)
                }
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isLoading = false
                }
            }
        }

 
  }



struct LinkDoneLoadingView: View {
    @ObservedObject var net = NetworkManager()
    var model : WebViewModel//(link: link)
    init(linkButton: LinkButton) {
        //self.link = link
        net=NetworkManager()
        model=WebViewModel(linkButton: linkButton)
        
        //print(link.absoluteString)
    }
    
    var body: some View {
            ZStack{
                
                VStack{
                    /*Text(showTitle).padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)).background(Color(red:0.0,green:191.0, blue: 255.0)).cornerRadius(15).font(Font.headline.weight(.bold)).foregroundColor(Color.black)*/
                WebView(webView: model.webView).opacity(abs(net.connectionDescription()-1.0))
                }
                
                Text("Network Error, please check your connection and try again.").foregroundColor(.white).font(.largeTitle).opacity(net.connectionDescription()).cornerRadius(15).font(Font.largeTitle.weight(.bold)).shadow(color: .black, radius: 2)

                
            }.background(Image("alt-home").resizable(resizingMode: .stretch).ignoresSafeArea(.all)
                              .aspectRatio(UIImage(named: "alt-home")!.size, contentMode: .fill))
            }
    
}
