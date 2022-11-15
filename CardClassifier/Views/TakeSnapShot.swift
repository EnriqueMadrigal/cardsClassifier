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
            
            
            Group {
                HStack{
                    Spacer()
                    CameraButton() {
                        self.sourceType = .camera
                        self.isImagePickerDisplay = true
                        
                    }
                    Spacer()
                    LibraryButton() {
                        self.sourceType = .photoLibrary
                        self.isImagePickerDisplay = true
                        
                        
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
                uploadModel.uploadFile()
            }.padding(.bottom,40)
            
        }// VStack
        .sheet(isPresented: self.$isImagePickerDisplay) {
           
                        ImagePickerView(selectedImage: self.$uploadModel.currentImage, sourceType: self.sourceType)
                    }
        
        
        
    }
}

struct TakeSnapShot_Previews: PreviewProvider {
    static var previews: some View {
        TakeSnapShot()
    }
}
