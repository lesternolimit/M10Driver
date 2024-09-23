import SwiftUI
import AVKit

struct VideoPlayerView: UIViewControllerRepresentable {
    let videoURL: URL

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let player = AVPlayer(url: videoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.showsPlaybackControls = false // Ne pas afficher les contrôles de lecture
        
        // Ajouter le contrôleur du lecteur comme enfant
        viewController.addChild(playerController)
        viewController.view.addSubview(playerController.view)
        playerController.view.frame = viewController.view.bounds
        playerController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Démarrer la lecture
        player.play()

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Mettre à jour le contrôleur si nécessaire
    }
}

