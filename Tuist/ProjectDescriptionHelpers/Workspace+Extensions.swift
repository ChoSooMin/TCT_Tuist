//
//  Workspace+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by 조수민 on 2023/07/18.
//

import Foundation
import ProjectDescription

extension Workspace {
    
    /// 프로젝트 공통 설정
    public enum CommonSetting {
        public static let organizationName: String = "Soomin Cho"
        public static let platform: ProjectDescription.Platform = .iOS
        public static let bundleIdReverseDomain: String = "kr.soomin"
        public static let deploymentTarget: DeploymentTarget = .iOS(targetVersion: "14.0", devices: [.iphone])
        public static let infoPlist: [String:InfoPlist.Value] = [
            "UILaunchStoryboardName": "LaunchScreen",
            
            // MARK: - version
            
            "CFBundleShortVersionString": "1.0.0",
            "CFBundleVersion": "1",
            
            // MARK: - UISupportedInterfaceOrientations, UISupportedInterfaceOrientations~ipad
            
            "UISupportedInterfaceOrientations": [
                "UIInterfaceOrientationPortrait"
            ],
            "UISupportedInterfaceOrientations~ipad": [
                "UIInterfaceOrientationPortrait"
            ],
            "BGTaskSchedulerPermittedIdentifiers": [
                "$(PRODUCT_BUNDLE_IDENTIFIER)"
            ]
        ]
        
    }
    
}
