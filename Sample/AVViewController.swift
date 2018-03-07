import UIKit
import AVKit
import AVFoundation

class AVViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 再生ボタン設定
        let button = UIButton(type: .system)
        button.setTitle("Play", for: .normal)
        button.addTarget(self, action: #selector(self.playMovieFromProjectBundle), for: .touchUpInside)
        // Documentディレクトリから動画を読み込む場合はこちら
        // button.addTarget(self, action: #selector(self.playMovieFromLocalFile), for: .touchUpInside)
        button.sizeToFit()
        button.center = self.view.center
        self.view.addSubview(button)
    }
    
    // アプリ内に組み込んだ動画ファイルを再生
    @objc func playMovieFromProjectBundle() {
        if let bundlePath = Bundle.main.path(forResource: "test", ofType: "mp4") {
            let videoPlayer = AVPlayer(url: URL(fileURLWithPath: bundlePath))
            // 動画プレイヤーの用意
            let playerController = AVPlayerViewController()
//            playerController.player = videoPlayer
            self.present(playerController, animated: true, completion: {
                videoPlayer.play()
            })
        } else {
            print("no such file")
        }
    }
    
    // アプリのDocumentディレクトリにある動画ファイルを再生
    func playMovieFromLocalFile() {
        let path = "\(getDocumentDirectory())/file.mp4"
        let videoPlayer = AVPlayer(url: URL(fileURLWithPath: path))
        // 動画プレイヤーの用意
        let playerController = AVPlayerViewController()
//        playerController.player = videoPlayer
        self.present(playerController, animated: true, completion: {
            videoPlayer.play()
        })
    }
    
    // Documentディレクトリのパスを取得
    func getDocumentDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
