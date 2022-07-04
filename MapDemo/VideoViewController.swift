//
//  VideoViewController.swift
//  MapDemo
//
//  Created by Nguyễn Đình Việt on 23/06/2022.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController, CALayerDelegate {
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var sliderTime: UISlider!
    @IBOutlet weak var volumeButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    var avOutput: AVCaptureOutput!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var isVideoPlaying = false
    var timer: Timer!
    
    var mix = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = URL(string: "https://kingnetwork.lotuscdn.vn/101685784788078592/2020/11/24/danh-ghen-16062216698972069161118.mp4")!
        player = AVPlayer()
        
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        playerItem.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        playerItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: [.new, .initial], context: nil)
        //Khoi tao trinh phat video
        player = AVPlayer(playerItem: playerItem)
        self.player.currentItem?.preferredForwardBufferDuration = TimeInterval(30.0)
        player.automaticallyWaitsToMinimizeStalling = true
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspect
        
        videoView.layer.addSublayer(playerLayer)
        player.play()
        addTimeObserver()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.bounds
    }
    
    @IBAction func volumeOnPress(_ sender: UIButton) {
        if self.player.isMuted == mix {
            self.player.isMuted = true
            volumeButton.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
        }
        else {
            self.player.isMuted = false
            volumeButton.setImage(UIImage(systemName: "speaker.2.fill"), for: .normal)
            
        }
    }
    func addTimeObserver() {
        sliderTime.minimumValue = 0
        sliderTime.value = 0
        sliderTime.maximumValue = Float((player?.currentItem?.asset.duration.seconds)!)
        
        
        guard let currentTime = player.currentItem else {return}
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.currentTimeLabel.text = self.getTimeString(from: currentTime.currentTime())
            self.sliderTime.value = Float((self.player?.currentTime().seconds)!)
        })
    }
    
    //MARK: Tua nguoc video
    func rewindVideo(by second: Float64) {
        //Lay thoi diem hien dang phat video
        if let currentTime = player?.currentTime() { //currentTime: tra ve thoi diem hien tai cua player
            var newTime = CMTimeGetSeconds(currentTime) - second
            
            //Neu tua ve qua 0 giay thi lay gia tri phat tai 0 giay
            if newTime <= 0 {
                newTime = 0
            }
            //Chuyen den thoi diem phat
            player?.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000))
        }
    }
    
    //MARK: Tua tiep video
    func fowardVideo(by second: Float64) {
        if let currentTime = player?.currentTime(), let duration = player?.currentItem?.duration {
            //duration: thoi luong cua video
            var newTime = CMTimeGetSeconds(currentTime) + second
            //Kiem tra neu tua qua thoi luong video
            if newTime >= CMTimeGetSeconds(duration) {
                newTime = CMTimeGetSeconds(duration)
            }
            player?.seek(to: CMTime(value: CMTimeValue(newTime*1000), timescale: 1000))
            
        }
    }
    @IBAction func fullOnPress(_ sender: UIButton) {
        if playerLayer.videoGravity == .resizeAspect {
            playerLayer.videoGravity = .resizeAspectFill
        }else{
            playerLayer.videoGravity = .resizeAspect
        }
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        
        //Kiem tra trang thai player
        if player?.rate != 0 && player?.error == nil{
            pauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            //Neu player dang phat thi tam dung phat
            player?.pause()
        }else {
            pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            //Neu dang dung thi cho chay
            player?.play()
        }
        
    }
    @IBAction func backwardPause(_ sender: UIButton) {
        rewindVideo(by: 15)
    }
    @IBAction func forwardPause(_ sender: UIButton) {
        fowardVideo(by: 15)
    }
    @IBAction func SliderValueChanged(_ sender: UISlider) {
        if (player?.currentTime()) != nil {
            //duration: thoi luong cua video
            let newTime = CMTime(value: CMTimeValue(sender.value*1000), timescale: 1000)
            player?.seek(to: newTime)
        }
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "duration", let duration = player.currentItem?.duration.seconds, duration > 0.0 {
            self.durationLabel.text = getTimeString(from: player.currentItem!.duration)
        }
        if keyPath == "loadedTimeRanges", let bufferTime = player.currentItem?.loadedTimeRanges.first?.timeRangeValue,
           let duration = player.currentItem?.duration.seconds, duration > 0.0{
            self.durationLabel.text = getTimeString(from: player.currentItem!.duration)
            self.progressView.progress = Float((bufferTime.start.seconds + bufferTime.duration.seconds) / duration)
        }
    }
    
    
    func getTimeString(from time: CMTime) -> String {
        let totalSeconds = CMTimeGetSeconds(time)
        let hours = Int(totalSeconds/3600)
        let minutes = Int(totalSeconds/60) % 60
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        if hours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [hours,minutes,seconds])
        }else {
            return String(format: "%02i:%02i", arguments: [minutes,seconds])
        }
    }
}

extension VideoViewController: AVCaptureAudioDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let formatDescription: CMFormatDescription = CMSampleBufferGetFormatDescription(sampleBuffer)!
        let imageBuffer: CVImageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        
        //CVPixelBufferLockBaseAddress(imageBuffer, Int(0))
        //var imagePointer: UnsafeMutablePointer<Void> = CVPixelBufferGetBaseAddress(imageBuffer)
        
        let bufferSize: (width: Int, height: Int) = (CVPixelBufferGetHeight(imageBuffer), CVPixelBufferGetWidth(imageBuffer))
        
        print("Buffer Size: \(bufferSize.width):\(bufferSize.height)")
    }
}
