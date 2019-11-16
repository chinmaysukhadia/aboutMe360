//
//  HelpViewController.swift
//  AboutMe360
//
//  Created by Himanshu Pal on 16/09/19.
//  Copyright © 2019 Appy. All rights reserved.
//

import UIKit
import WebKit

enum WebContentType {
    case none
    case help
    case termAndCondition
    
    var url: String? {
        switch self {
        case .none: return "https://www.google.com/"
        case .help: return "http://aboutme360.com/frequently-asked-questions.html"
        case .termAndCondition:
            return "http://www.aboutme360.com/terms-and-conditions.html"
        }
    }
    
    var title: String? {
        switch self {
        case .help: return "Help"
        case .none:
            return ""
        case .termAndCondition:
             return "Terms & Conditions"
        }
    }
    
}

class HelpViewController: BaseViewController {

    //MARK: - IBOutlets

  //  @IBOutlet weak var helpTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Variables
    
    var webView: WKWebView!
    var webContentType: WebContentType = .none
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUp()
    }
    
    //MARK: - Private Methods
    
    private func setUp() {
//        self.helpTableView.delegate = self
//        self.helpTableView.dataSource = self
//        self.registerCell()
        self.titleLabel.text = webContentType.title
        self.setupWebView()
    }
    
//    private func registerCell() {
//        helpTableView.register(nibs: [HelpCell.className])
//    }
    
    private func setupWebView() {
        
        let webConfiguration = WKWebViewConfiguration()
        let customFrame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 0.0, height: self.holderView.frame.size.height))
        webView = WKWebView (frame: customFrame , configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        
        holderView.addSubview(webView)
        webView.topAnchor.constraint(equalTo: holderView.topAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: holderView.rightAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: holderView.leftAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: holderView.bottomAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: holderView.heightAnchor).isActive = true
        webView.uiDelegate = self
        self.activityIndicatorView.hidesWhenStopped = true
        loadUrl(webContentType.url)

    }
    
    private func loadUrl(_ url: String?) {
        if let safeUrlStr = url, let safeUrl = URL(string: safeUrlStr) {
            Threads.performTaskInMainQueue {
                if let webVeiw = self.webView {
                    webVeiw.load(URLRequest(url: safeUrl))
                }
            }
        }
    }
    
    //MARK: - IBAction
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


//extension HelpViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if let cell = tableView.dequeueReusableCell(withIdentifier: HelpCell.className, for: indexPath) as? HelpCell {
//            cell.selectionStyle = .none
//
//            return cell
//        }
//
//        return UITableViewCell()
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        guard let  helpDetailsVC = DIConfigurator.helpDetailsViewController() as? HelpDetailsViewController  else {
//            return
//        }
//        self.navigationController?.pushViewController(helpDetailsVC, animated: true)
//    }
//
//}

// MARK: - WKUIDelegate

extension HelpViewController: WKUIDelegate ,WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        self.activityIndicatorView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Start to load")
        self.activityIndicatorView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        self.activityIndicatorView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil, let url = navigationAction.request.url{
            if url.description.lowercased().range(of: "http://") != nil || url.description.lowercased().range(of: "https://") != nil  {
                webView.load(navigationAction.request)
            }
        }
        return nil
    }
    
    
}
