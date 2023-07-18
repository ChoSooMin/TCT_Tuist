//
//  TargetDependency+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by 조수민 on 2023/07/18.
//

import ProjectDescription

/// 프로젝트 내/외부 종속성
extension TargetDependency {
    
    // MARK: - SDK (시스템 라이브러리 종속성)
    
    public enum SDK {
        public static let combine: TargetDependency = .sdk(name: "Combine", type: .framework, status: .required)
    }
    
    // MARK: - External (외부 라이브러리 종속성 - carthage, swiftPackageManager etc)
    
    public enum External {
        public static let combineExt = TargetDependency.external(name: "CombineExt")
        public static let kingfisher = TargetDependency.external(name: "Kingfisher")
        public static let modernRIBs = TargetDependency.external(name: "ModernRIBs")
        public static let combineInterception = TargetDependency.external(name: "CombineInterception")
        public static let moya = TargetDependency.external(name: "Moya")
        public static let then = TargetDependency.external(name: "Then")
        public static let snapKit = TargetDependency.external(name: "SnapKit")
        public static let alamofire = TargetDependency.external(name: "Alamofire")
        public static let combineMoya = TargetDependency.external(name: "CombineMoya")
    }
    
    // MARK: - Network
    
    public enum Network {
        
        // MARK: - Network
        
        public static let network: TargetDependency = .project(target: "Network", path: .relativeToRoot("Projects/Network"))
        
    }
    
}
