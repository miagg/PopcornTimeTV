//
//  DownloadButtonViewModel.swift
//  PopcornTimetvOS SwiftUI
//
//  Created by Alexandru Tudose on 24.06.2021.
//  Copyright © 2021 PopcornTime. All rights reserved.
//

import SwiftUI
import PopcornTorrent
import PopcornKit
import MediaPlayer
import Combine

class DownloadButtonViewModel: NSObject, ObservableObject {
    var media: Media
    var torrent: Torrent?
    var download: PTTorrentDownload?
    @Published var state: State = .normal
    @Published var showStopDownloadAlert = false
    @Published var showDownloadFailedAlert = false
    @Published var showDownloadedActionSheet = false
    @Published var downloadError: Error?
    @Published var downloadProgress: Float = 0
    
    enum State: CaseIterable {
        case normal
        case pending
        case downloading
        case paused
        case downloaded
        
        init(_ downloadStatus: PTTorrentDownloadStatus) {
            switch downloadStatus {
            case .downloading: self = .downloading
            case .paused: self = .paused
            case .processing: self = .pending
            case .finished: self = .downloaded
            case .failed: self = .normal
            @unknown default:
                fatalError()
            }
        }
    }
    
    init(media: Media) {
        self.media = media
        self.download = media.associatedDownload
        state = download.flatMap{ State($0.downloadStatus) } ?? .normal
        super.init()
        PTTorrentDownloadManager.shared().add(self)
        print(self.media.title, "state: ", state)
    }
    
    deinit {
        PTTorrentDownloadManager.shared().remove(self)
    }
    
    func download(torrent: Torrent) {
        self.download = PTTorrentDownloadManager.shared().startDownloading(fromFileOrMagnetLink:  torrent.url, mediaMetadata: self.media.mediaItemDictionary)
        print("download torrent", torrent)
        state = .pending
    }
    
    func stopDownload() {
        guard let download = download else { return }
        PTTorrentDownloadManager.shared().stop(download)
        state = .normal
    }
    
    func deleteDownload() {
        guard let download = download else { return }
        PTTorrentDownloadManager.shared().delete(download)
        self.download = nil
        state = .normal
    }
    
    func resumeDownload() {
        guard let download = download else { return }
        download.resume()
        state = .downloading
    }
}

extension DownloadButtonViewModel: PTTorrentDownloadManagerListener {
    func torrentStatusDidChange(_ torrentStatus: PTTorrentStatus, for download: PTTorrentDownload) {
        guard download === self.download else { return }
        downloadProgress = torrentStatus.totalProgress
        print("download progress", downloadProgress)
    }
    
    func downloadStatusDidChange(_ downloadStatus: PTTorrentDownloadStatus, for download: PTTorrentDownload) {
        guard download === self.download else { return }
        state = State(downloadStatus)
    }
    
    func downloadDidFail(_ download: PTTorrentDownload, withError error: Error) {
        guard download === self.download else { return }
        
        downloadError = error
        showDownloadFailedAlert = true
    }
}
