//
//  AddPostViewController.swift
//  PlatziTweets
//
//  Created by Javier Rodríguez Gómez on 18/3/23.
//

import AVFoundation
import AVKit
import CoreLocation
import FirebaseStorage
import MobileCoreServices
import NotificationBannerSwift
import Simple_Networking
import SVProgressHUD
import UIKit

class AddPostViewController: UIViewController {
    // MARK: - IBOUTLETS
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var videoButton: UIButton!
    
    // MARK: - Properties
    private var imagePicker: UIImagePickerController?
    private var currentVideoURL: URL?
    private var locationManager: CLLocationManager?
    private var userLocation: CLLocation?
    
    // MARK: - IBACTIONS
    
    @IBAction func openCameraAction() {
        let alert = UIAlertController(title: "Cámara", message: "Selecciona una opción", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Foto", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Vídeo", style: .default, handler: { _ in
            self.openVideoCamera()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alert, animated: true)
    }
    
    @IBAction func addPostAction() {
        if currentVideoURL != nil {
            uploadPhotoToFirebase()
            return
        }
        
        if previewImageView.image != nil {
            uploadPhotoToFirebase()
            return
        }
        
        savePost(imageUrl: nil, videoUrl: nil)
    }
    
    @IBAction func dismissAction() {
        dismiss(animated: true)
    }
    
    @IBAction func openPreviewAction() {
        if let currentVideoURL {
            let avPlayer = AVPlayer(url: currentVideoURL) // este es el vídeo
            let avPlayerController = AVPlayerViewController() // este abre pantalla con la reproducción del vídeo
            avPlayerController.player = avPlayer
            present(avPlayerController, animated: true) {
                // Reproducir el vídeo automáticamente
                avPlayerController.player?.play()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoButton.isHidden = true
        requestLocation()
    }
    
    // MARK: - Methods
    
    private func requestLocation() {
        // Validar que el GPS esté activo y disponible
        guard CLLocationManager.locationServicesEnabled() else { return }
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = .greatestFiniteMagnitude
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
    }
    
    private func openCamera() {
        imagePicker = UIImagePickerController()
        imagePicker?.sourceType = .photoLibrary
//        imagePicker?.sourceType = .camera
//        imagePicker?.cameraFlashMode = .off
//        imagePicker?.cameraCaptureMode = .photo
        imagePicker?.allowsEditing = true
        imagePicker?.delegate = self
        
        guard let imagePicker else { return }
        present(imagePicker, animated: true)
    }
    
    private func openVideoCamera() {
        imagePicker = UIImagePickerController()
        imagePicker?.sourceType = .camera
        imagePicker?.mediaTypes = [kUTTypeMovie as String]
        imagePicker?.cameraFlashMode = .off
        imagePicker?.cameraCaptureMode = .video
        imagePicker?.videoQuality = .typeMedium
        imagePicker?.videoMaximumDuration = 5
        imagePicker?.allowsEditing = true
        imagePicker?.delegate = self
        
        guard let imagePicker else { return }
        present(imagePicker, animated: true)
    }
    
    private func uploadPhotoToFirebase() {
        // Asegurar que la foto existe y convertirla a Data con compresión
        guard let imageSaved = previewImageView.image,
        let imageSavedData = imageSaved.jpegData(compressionQuality: 0.1) else { return }
        
        SVProgressHUD.show()
        
        // Configuración para guardar en Firebase
        let metaDataConfig = StorageMetadata()
        metaDataConfig.contentType = "image/jpg"
        
        // Referencia al storage de Firebase
        let storage = Storage.storage()
        
        // Crear nombre de imagen a subir, no se pueden repetir
        let imageName = UUID().uuidString
        
        // Referencia a la carpeta dónde guardar la foto
        let folderReference = storage.reference(withPath: "fotos-tweets/\(imageName).jpg")
        
        // Subir la foto a firebase, en hilo secundario
        DispatchQueue.global(qos: .background).async {
            folderReference.putData(imageSavedData, metadata: metaDataConfig) { metaData, error in
                // Tenemos que hacer lo siguiente de nuevo en el hilo principal
                DispatchQueue.main.async {
                    // Detener la carga
                    SVProgressHUD.dismiss()
                    if let error {
                        NotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .warning).show()
                        print(error.localizedDescription)
                        return
                    }
                    // Obtener la URL de descarga
                    folderReference.downloadURL { url, error in
                        let downloadUrl = url?.absoluteString ?? ""
                        self.savePost(imageUrl: downloadUrl, videoUrl: nil)
                    }
                }
            }
        }
    }
    
    private func uploadVideoToFirebase() {
        guard let currentVideoSavedURL = currentVideoURL,
              let videoData = try? Data(contentsOf: currentVideoSavedURL) else { return }
        
        SVProgressHUD.show()
        
        // Configuración para guardar en Firebase
        let metaDataConfig = StorageMetadata()
        metaDataConfig.contentType = "video/mp4"
        
        // Referencia al storage de Firebase
        let storage = Storage.storage()
        
        // Crear nombre de vídeo a subir, no se pueden repetir
        let videoName = UUID().uuidString
        
        // Referencia a la carpeta dónde guardar el vídeo
        let folderReference = storage.reference(withPath: "video-tweets/\(videoName).mp4")
        
        // Subir el vídeo a firebase, en hilo secundario
        DispatchQueue.global(qos: .background).async {
            folderReference.putData(videoData, metadata: metaDataConfig) { metaData, error in
                // Tenemos que hacer lo siguiente de nuevo en el hilo principal
                DispatchQueue.main.async {
                    // Detener la carga
                    SVProgressHUD.dismiss()
                    if let error {
                        NotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .warning).show()
                        print(error.localizedDescription)
                        return
                    }
                    // Obtener la URL de descarga
                    folderReference.downloadURL { url, error in
                        let downloadUrl = url?.absoluteString ?? ""
                        self.savePost(imageUrl: nil, videoUrl: downloadUrl)
                    }
                }
            }
        }
    }
    
    private func savePost(imageUrl: String?, videoUrl: String?) {
        var postLocation: PostRequestLocation?
        if let userLocation {
            postLocation = PostRequestLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        }
        
        // Crear request
        let request = PostRequest(text: postTextView.text, imageUrl: imageUrl, videoUrl: videoUrl, location: postLocation)
        
        // Indicar carga
        SVProgressHUD.show()
        
        // Llamar al servicio del post
        SN.post(endpoint: Endpoints.post, model: request) { (response: SNResultWithEntity<Post, ErrorResponse>) in
            // Cerrar indicador de carga
            SVProgressHUD.dismiss()
            
            switch response {
            case .success:
                // Se guarda el post y la pantalla debe cerrarse
                self.dismiss(animated: true)
            case .error(let error):
                NotificationBanner(title: "Error", subtitle: "Algo ha ido mal: \(error.localizedDescription).", style: .danger).show()
                print(error.localizedDescription)
            case .errorResult(let entity):
                NotificationBanner(title: "Error", subtitle: "Algo ha fallado: \(entity.error).", style: .warning).show()
            }
        }
    }
}


extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Delegado para saber si se ha tomado la foto
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Cerrar cámara
        imagePicker?.dismiss(animated: true)
        
        // Capturar imagen
        if info.keys.contains(.originalImage) {
            previewImageView.isHidden = false
            // Obtenemos la imagen tomada
            previewImageView.image = info[.originalImage] as? UIImage
        }
        
        // Capturar URL del vídeo
        if info.keys.contains(.mediaURL), let recordedVideoURL = (info[.mediaURL] as? URL)?.absoluteURL {
            // Mostrar el botón de ver el vídeo solo si hay uno guardado
            videoButton.isHidden = false
            currentVideoURL = recordedVideoURL
        }
    }
}

extension AddPostViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let bestLocation = locations.last else { return }
        
        // Ya tenemos la ubicación del usuario
        userLocation = bestLocation
    }
}
