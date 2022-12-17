//
//  View+Ext.swift
//  DeveloperMediaBlog
//
//  Created by Hertz on 12/17/22.
//

import Foundation
import SwiftUI

// MARK: View Extensions For UI Building
extension View{
    
    // MARK: - 키보드 내리기
    func closeKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // MARK: 선택해제되면 투명도 변경
    func disableWithOpacity(_ condition: Bool)->some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    
    // MARK: - 가로영억 다 차지하고 정렬을 설정
    func hAlign(_ alignment: Alignment)->some View{
        self
            .frame(maxWidth: .infinity,alignment: alignment)
    }
    
    // MARK: - 세로영역 다 차지하고 정렬을 설정
    func vAlign(_ alignment: Alignment)->some View{
        self
            .frame(maxHeight: .infinity,alignment: alignment)
    }
    
    // MARK: Custom Border View With Padding
    // MARK: 커스텀 보더
    func border(_ width: CGFloat,_ color: Color)->some View{
        self
            .padding(.horizontal,15)
            .padding(.vertical,10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(color, lineWidth: width)
            }
    }
    
    // MARK: Custom Fill View With Padding
    // MARK: 뷰 색상 채우기 커스텀 뷰
    func fillView(_ color: Color)->some View{
        self
            .padding(.horizontal,15)
            .padding(.vertical,10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(color)
            }
    }
}
