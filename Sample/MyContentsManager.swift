//
//  MyContentsManager.swift
//  Sample
//
//  Created by Watanabe Takehiro on 2018/03/05.
//  Copyright © 2018年 Watanabe Takehiro. All rights reserved.
//

import Foundation

class MyContentsManager: NSObject {
    
    lazy var configuration: URLSessionConfiguration = {
        return URLSessionConfiguration.background(withIdentifier: "some unique identifier")
    }()
    
    lazy var session: URLSession = {
        return URLSession(configuration: self.configuration, delegate: self, delegateQueue: nil)
    }()
    
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    
    static let shared = MyContentsManager()
    
    private override init () {}
    
    func startDownloading() {
        let task = self.session.downloadTask(with: URL(string: "https://your.domain.com/some_large_data.dat")!)
        // 識別子作成
        let dictionary = ["type": "Book", "path": "contents/book102", "compress": "zip"]
        let jsonData = try! JSONSerialization.data(withJSONObject: dictionary, options: [])
        let jsonString = String(bytes: jsonData, encoding: .utf8)
        task.taskDescription = jsonString
        // 実行
        task.resume()
    }
    
}

extension MyContentsManager: URLSessionDownloadDelegate {
    
    // ダウンロード終了時に呼び出されるデリゲート location の URL にダウンロードされたファイルが用意されている
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //
    }
    
    // タスク終了時に呼び出されるデリゲート ダウンロードに失敗しても成功しても
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        //
    }
    
    // ダウンロードの開始時に呼び出されるデリゲート
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        //
    }
    
    // タスク処理中に定期的に呼び出されるデリゲート
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        //
    }
}
