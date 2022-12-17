//
//  RegisterView.swift
//  DeveloperMediaBlog
//
//  Created by Hertz on 12/17/22.
//
import SwiftUI
import Combine


struct RegisterView: View {
    
    @StateObject var registerVM = RegisterVM()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                Text("회원가입")
                    .font(.largeTitle.bold())
                    .hAlign(.leading)
                
                Text("고객님 안녕하세요, \n환상적인 여정이 기다리고 있습니다")
                    .font(.title3)
                    .hAlign(.leading)
                
                // MARK: 작은사이즈 아이폰 최적화
                ViewThatFits {
                    ScrollView(.vertical, showsIndicators: false) {
                        helperView()
                    }
                    helperView()
                }
                
                // MARK: 회원가입 버튼
                HStack{
                    Text("계정을 가지고 있습니까?")
                        .foregroundColor(.gray)
                    
                    Button {
                        dismiss()
                        closeKeyboard()
                    } label: {
                        Text("로그인 하러가기")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                }
                .font(.callout)
                .vAlign(.bottom)
            }
            .vAlign(.top)
            .padding(15)
            .overlay(
                // MARK: - 로딩뷰 들어갈 자리
                LoadingView(show: $registerVM.isLoading)
            )
            .photosPicker(isPresented: $registerVM.showImagePicker, selection: $registerVM.photoItem)
            .onChange(of: registerVM.photoItem) { photoPickerItem in
                // MARK: - photoItem에서 UIImage 추출
                // MARK: - 포토아이템 터트리기
                registerVM.selectedPhotoItem()
                
            }
            // MARK: 디스플레잉 얼럿
            .alert(registerVM.errorMessage, isPresented: $registerVM.showError, actions: {})

        }
        
    }
    @ViewBuilder
    func helperView() -> some View {
        
        VStack(spacing: 12) {
            ZStack{
                if let image = UIImage(data: registerVM.userProfilePicData ?? Data()) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }else{
                    Image("NullProfile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: 85, height: 85)
            .clipShape(Circle())
            .contentShape(Circle())
            .onTapGesture {
                registerVM.showImagePicker = true
            }
            .padding(.top, 25)
            
            TextField("닉네임", text: $registerVM.userName)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            TextField("이메일", text: $registerVM.emailID)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            SecureField("패스워드", text: $registerVM.password)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            TextField("소개", text: $registerVM.userBio,axis: .vertical)
                .frame(minHeight: 100,alignment: .top)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            TextField("소개 링크 (Optional)", text: $registerVM.userBioLink)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            Button {
                // MARK: - 중요
                registerVM.registerUser()
                closeKeyboard()
            } label: {
                // MARK: 회원가입후 로그인
                Text("시작하기")
                    .foregroundColor(.white)
                    .hAlign(.center)
                    .fillView(.black)
            }
            .disableWithOpacity(registerVM.userName == "" ||
                                registerVM.userBio == "" ||
                                registerVM.emailID == "" ||
                                registerVM.password == "" ||
                                registerVM.userProfilePicData == nil)
            .padding(.top,10)
            
        } // Button
        
    }
    
    
}


//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView()
//    }
//}
