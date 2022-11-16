//
//  TakeSnapShot.swift
//  CardClassifier
//
//  Created by Algrthm on 14/11/22.
//

import SwiftUI

struct TakeSnapShot: View {
    
    //Camera
    @State private var sourceType: UIImagePickerController.SourceType = .camera
       // @State private var selectedImage: UIImage?
        @State private var isImagePickerDisplay = false
    
     
   
    @StateObject var uploadModel = SnapShotViewModel()
    
    var body: some View {
       
        VStack {
            
            Group {
                Divider()
            }.padding(.top,10)
            
            
            Header3(text: "Take a photo of your card").padding(.top,20)
            
            ZStack {
                
            HStack{
                Spacer()
                
                if  uploadModel.currentImage != nil {
                    Image(uiImage: uploadModel.currentImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    //.clipShape(Circle())
                        .frame(width: 220, height: 280)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                    
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    //.clipShape(Circle())
                        .frame(width: 220, height: 280)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                    
                }
                
                
                
                
                
                
                Spacer()
                
                
            }.padding(.top,20).padding(.leading,20).padding(.trailing,20)
            
                VStack {
                    if let currentData = uploadModel.PokemonData {
                        
                        InformationView(PokemonData: currentData)
                        CustomButton(text: "OK"){
                            uploadModel.PokemonData = nil
                        }.padding(.top,10).padding(.bottom,10)
                    }
                    
                    
                }.frame(width: 360).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                    .background(Color(UIColor.AppGray3))
                /*
                    .padding(.leading,20).padding(.trailing,20).foregroundColor(.white)
                    .background(Color.gray)
                */
            }
            
            Group {
                HStack{
                    Spacer()
                    CameraButton() {
                        if uploadModel.PokemonData == nil {
                            uploadModel.isCamera = true
                            self.isImagePickerDisplay = true
                        }
                        
                    }
                    Spacer()
                    LibraryButton() {
                        if uploadModel.PokemonData == nil {
                            uploadModel.isCamera = false
                            self.isImagePickerDisplay = true
                        }
                        
                    }
                    
                    Spacer()
                }.padding(.top,20).padding(.leading,20).padding(.trailing,20)
            }
            
            
            if uploadModel.showProgressView{
                ProgressView().scaleEffect(x: 2, y:2, anchor: .center)
                
            }
            
            
            Spacer() .alert(item: $uploadModel.error){error in
                Alert(title: Text("Error"), message: Text(error.localizedDescription))
                
            }
            
            
     
            
            
            CustomButton(text: "Upload your photo") {
                if uploadModel.PokemonData == nil {
                    uploadModel.uploadFile()
                }
                
            }.padding(.bottom,40)
            
        }// VStack
        .sheet(isPresented: self.$isImagePickerDisplay) {
           
       
                if uploadModel.isCamera{
                    ImagePickerView(selectedImage: self.$uploadModel.currentImage, sourceType: UIImagePickerController.SourceType.camera)
                    
                }
                else {
                    ImagePickerView(selectedImage: self.$uploadModel.currentImage, sourceType: UIImagePickerController.SourceType.photoLibrary)
                }
                
            }
            
            
             
        
        
    }
}

struct TakeSnapShot_Previews: PreviewProvider {
    static var previews: some View {
        TakeSnapShot()
    }
}
