//
//  ImageFullViewController.swift
//  UnsplashApiApp
//
//  Created by Berta Devant on 14/08/2019.
//  Copyright © 2019 Berta Devant. All rights reserved.
//

import UIKit

protocol ImageActionsDelegate: class {
    func shareImage()
    func download()
    func dismiss()
}

class ImageFullViewController: UIViewController {
    private let imageView = ImageFullScreenView()
    private let imageFullViewModel: ImageFullViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(image: ImageViewState) {
        self.imageFullViewModel = ImageFullViewModel(image: image)
        super.init(nibName: nil, bundle: nil)
        setupImageView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.pinToSuperviewEdges()
        imageView.bind(imageFullViewModel.image)
    }
    
    private func setupImageView() {
        imageView.delegate = self
        view.addSubview(imageView)
        imageView.pinToSuperviewEdges()
    }
}

extension ImageFullViewController: ImageActionsDelegate {
    func shareImage() {
        imageFullViewModel.share() { image, _ in
            guard let image = image else {
                return
            }
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.imageView.shareButton
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func download() {
        imageFullViewModel.download()
        imageView.downloadButton(isLoading: true)
        imageFullViewModel.imageSavedDelegate = { [weak self] _, error, _ in
            self?.imageView.downloadButton(isLoading: false)
            guard let error = error else {
                return
            }
            print("error while saving image \(error)")
        }
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
