//
//  ImageSettingViewController.swift
//  MVVMPractice
//
//  Created by 조우현 on 2/10/25.
//

import UIKit

final class ImageSettingViewController: BaseViewController {
    
    private var imageSettingView = ImageSettingView()
    let viewModel = ImageSettingViewModel()
    let imageList = ProfileImage.allCases
    
    // MARK: - LifeCycle
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.input.previewImage.value = imageSettingView.previewImage
    }
    
    deinit {
        print("ImageSettingViewController Deinit")
    }
    
    // MARK: - Functions
    override func loadView() {
        view = imageSettingView
    }
    
    override func configureEssential() {
        imageSettingView.imageCollectionView.delegate = self
        imageSettingView.imageCollectionView.dataSource = self
        imageSettingView.imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.id)
    }
    
    override func configureView() {
        navigationItem.title = "프로필 이미지 설정"
    }
    
    override func bindData() {
        viewModel.output.receiveImage.bind { [weak self] data in
            self?.imageSettingView.previewImage.image = data?.image
        }
        
        viewModel.output.cellSelected.lazyBind { [weak self] data in
            self?.imageSettingView.previewImage.image = data?.image
        }
    }
}

// MARK: - Extension
extension ImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageSettingView.imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.id, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        let data = imageList[indexPath.item]
        
        cell.imageSelection.image = data.image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = imageList[indexPath.item]
        viewModel.input.cellSelected.value = data
    }
}
