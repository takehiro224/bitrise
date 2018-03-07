//
//  ViewController.swift
//  Sample
//
//  Created by Watanabe Takehiro on 2018/03/02.
//  Copyright © 2018年 Watanabe Takehiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController: URLSessionDownloadDelegate {
    
    // ダウンロード終了時に呼び出されるデリゲート
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //
    }
    
    // タスク終了時に呼び出されるデリゲート
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
