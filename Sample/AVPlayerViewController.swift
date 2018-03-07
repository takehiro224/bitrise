//
//  AVPlayerViewController.swift
//  Sample
//
//  Created by Watanabe Takehiro on 2018/03/06.
//  Copyright © 2018年 Watanabe Takehiro. All rights reserved.
//

import UIKit
import AVFoundation

// MARK:- レイヤーをAVPlayerLayerにする為のラッパークラス.
class AVPlayerView: UIView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}

class AVPlayerViewController: UIViewController {
    
    // 再生用のアイテム
    var playerItem : AVPlayerItem!
    
    // AVPlayer
    var videoPlayer : AVPlayer!
    
    // シークバー
    var seekBar : UISlider!
    
    // 動画再生オブザーバー
    var periodicTimeObserver: Any?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 動画ファイルのパス取得
        let path = Bundle.main.path(forResource: "test", ofType: "mp4")
        // 動画のURLを取得
        let fileURL = URL(fileURLWithPath: path!)
        // 動画のアセットを取得
        let avAsset = AVURLAsset(url: fileURL)
        
        // 再生させるアイテムを生成
        playerItem = AVPlayerItem(asset: avAsset)
        
        // AVPlayerを生成
        videoPlayer = AVPlayer(playerItem: playerItem)
        
        // Viewを生成
        let videoPlayerView = AVPlayerView(frame: self.view.bounds)
        
        // UIViewのレイヤーをAVPlayerLayerにする
        let layer = videoPlayerView.layer as! AVPlayerLayer
        layer.videoGravity = AVLayerVideoGravity.resizeAspect
        layer.player = videoPlayer
        // レイヤーを追加する
        self.view.layer.addSublayer(layer)
        
        // 動画のシークバーとなるUISliderを生成
        self.createSeekBar(avAsset: avAsset)
        
        /* シークバーを動画とシンクロさせる為の処理 */
        // 0.5分割で動かす事が出来る様にインターバルを指定
        let interval: Double = Double(0.5 * seekBar.maximumValue) / Double(seekBar.bounds.maxX) // 0.107
        // CMTimeに変換する
        let time: CMTime = CMTimeMakeWithSeconds(interval, Int32(NSEC_PER_SEC))
        // time毎に呼び出される
        periodicTimeObserver = videoPlayer.addPeriodicTimeObserver(forInterval: time, queue: nil) { time in
            // 総再生時間を取得
            let duration: Float64 = CMTimeGetSeconds(self.videoPlayer.currentItem!.duration)
            // 現在の時間を取得
            let time: Float64 = CMTimeGetSeconds(self.videoPlayer.currentTime())
            // シークバーの位置を変更
            let value: Float = Float(self.seekBar.maximumValue - self.seekBar.minimumValue) * Float(time) / Float(duration) + Float(self.seekBar.minimumValue)
            self.seekBar.value = value
        }
        
        // 動画の再生ボタンを生成
        self.createPlayButton()
    }
    
    private func createSeekBar(avAsset: AVURLAsset) {
        seekBar = UISlider(frame: CGRect(x: 0, y: 0, width: self.view.bounds.maxX - 100, height: 50))
        seekBar.layer.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.maxY - 100)
        seekBar.minimumValue = 0
        seekBar.maximumValue = Float(CMTimeGetSeconds(avAsset.duration))
        seekBar.addTarget(self, action: #selector(onSliderValueChange(sender:)), for: UIControlEvents.valueChanged)
        self.view.addSubview(seekBar)
    }
    
    private func createPlayButton() {
        // 動画の再生ボタンを生成.
        let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        startButton.layer.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.maxY - 50)
        startButton.layer.masksToBounds = true
        startButton.layer.cornerRadius = 20.0
        startButton.backgroundColor = UIColor.orange
        startButton.setTitle("Start", for: UIControlState.normal)
        startButton.addTarget(self, action: #selector(onButtonClick(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(startButton)
    }
    
    // シークバーの値が変わった時に呼ばれるメソッド.
    @objc func onSliderValueChange(sender : UISlider){
        // 動画の再生時間をシークバーとシンクロさせる.
        videoPlayer.seek(to: CMTimeMakeWithSeconds(Float64(seekBar.value), Int32(NSEC_PER_SEC)))
    }
    
    // 再生ボタンが押された時に呼ばれるメソッド.
    @objc func onButtonClick(sender : UIButton){
        // 再生時間を最初に戻す
        videoPlayer.seek(to: CMTimeMakeWithSeconds(0, Int32(NSEC_PER_SEC)))
        // 再生
        videoPlayer.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
