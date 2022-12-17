//
//  LogInView.swift
//  DeveloperMediaBlog
//
//  Created by Hertz on 12/17/22.
//

import SwiftUI
import Firebase

struct LogInView: View {
    
    @StateObject var logInVM = LogInVM()
    
    // MARK: User Defaults
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            Text("로그인")
                .font(.largeTitle.bold())
                .hAlign(.leading)
            
            Text("환영합니다, \n보고싶었습니다")
                .font(.title3)
                .hAlign(.leading)
            
            VStack(spacing: 12) {
                TextField("Email", text: $logInVM.emailID)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top,25)
                
                SecureField("Password", text: $logInVM.password)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                
                Button {
                    logInVM.resetPassword()
                } label: {
                    Text("비밀번호 재설정")
                        .font(.callout)
                        .fontWeight(.medium)
                        .tint(.black)
                        .hAlign(.trailing)
                }

                
                Button {
                    logInVM.logInUser()
                    closeKeyboard()
                } label: {
                    Text("로그인")
                        .foregroundColor(.white)
                        .hAlign(.center)
                        .fillView(.black)
                }
                .padding(.top, 10)
                

                // MARK: 회원가입 버튼
                HStack{
                    Text("계정이 없으신가요?")
                        .foregroundColor(.gray)
                    
                    Button("회원가입"){
                        logInVM.createAccount.toggle()
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                }
                .font(.callout)
                .vAlign(.bottom)
                
            }
            
        }
        .vAlign(.top)
        .padding(15)
        .overlay(content: {
            // MARK: - 로딩뷰 추가 예정
        })
        // MARK: 레지스터 뷰 추가 예정
        .fullScreenCover(isPresented: $logInVM.createAccount) {
            RegisterView()
        }
        // MARK: 디스플레잉 얼럿
        .alert(logInVM.errorMessage, isPresented: $logInVM.showError, actions: {})
    }
}



struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
