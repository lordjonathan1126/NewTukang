//
//  RefreshScrollView.swift
//  NewTukang
//
//  Created by Jonathan Ng on 08/10/2020.
//  Copyright © 2020 Jonathan Ng. All rights reserved.
//

import SwiftUI
import UIKit

struct RefreshScrollView: UIViewRepresentable {
    var width:CGFloat
    var height: CGFloat
    
    @ObservedObject var webService = WebService()
   
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(context.coordinator, action: #selector(Coordinator.handleRefreshControl(sender:)), for: .valueChanged)
        let refreshVC = UIHostingController(rootView: HomeView())
        refreshVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height - 50)
        scrollView.addSubview(refreshVC.view)
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, webService: webService)
    }
    
    class Coordinator: NSObject{
        var refreshScrollView: RefreshScrollView
        var webService: WebService
        
        init(_ refreshScrollView: RefreshScrollView, webService: WebService){
            self.refreshScrollView = refreshScrollView
            self.webService = webService
        }
        
       @objc func handleRefreshControl(sender: UIRefreshControl){
        sender.endRefreshing()
        DispatchQueue.global(qos: .userInitiated).async{
            self.webService.getPosts()
        }
        }
    }
}


