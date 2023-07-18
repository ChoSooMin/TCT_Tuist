import ProjectDescription

extension Target {

    /// Target Type
    public enum TargetType: Hashable {

        /// Target Source
        public struct TargetSource: Hashable {
            /// Sources
            public let sources: SourceFilesList?
            /// Resources
            public let resources: ResourceFileElements?

            // MARK: - Hashable

            public func hash(into hasher: inout Hasher) {
                hasher.combine(0)
            }

            public init(
                sources: SourceFilesList? = nil,
                resources: ResourceFileElements? = nil
            ) {
                self.sources = sources
                self.resources = resources
            }
        }

        /// staticLibrary
        ///
        /// - targetSource: TargetSource
        /// - testsTargetSource: Test TargetSource (target unitTests 용)
        case staticLibrary(targetSource: TargetSource, testsTargetSource: TargetSource? = nil)
        /// dynamicFramework
        ///
        /// - targetSource: TargetSource
        /// - testsTargetSource: Test TargetSource (target unitTests 용)
        case dynamicFramework(targetSource: TargetSource, testsTargetSource: TargetSource? = nil)
        /// staticFramework
        ///
        /// - targetSource: TargetSource
        /// - testsTargetSource: Test TargetSource (target unitTests 용)
        case staticFramework(targetSource: TargetSource, testsTargetSource: TargetSource? = nil)
    }

    /// Make targets based on name
    ///
    /// - Parameters:
    ///   - bundleIdReverseDomain: 번들 접두어
    ///     - Framework Target: "\(bundleIdReverseDomain).\(name)"
    ///     - Framework Tests Target: "\(bundleIdReverseDomain).\(name)Tests"
    ///   - targetTypes: name 기반으로 추가될 타겟들
    /// - Returns: [Target]
    public static func makeTargets(
        name: String,
        platform: Platform,
        productName: String? = nil,
        bundleIdReverseDomain: String,
        deploymentTarget: DeploymentTarget? = nil,
        infoPlist: InfoPlist? = .default,
        targetTypes: Set<TargetType>,
        copyFiles: [CopyFilesAction]? = nil,
        headers: Headers? = nil,
        entitlements: Path? = nil,
        scripts: [TargetScript] = [],
        dependencies: [TargetDependency] = [],
        testDependencies: [TargetDependency] = [],
        settings: Settings? = nil,
        coreDataModels: [CoreDataModel] = [],
        environment: [String: String] = [:],
        launchArguments: [LaunchArgument] = [],
        additionalFiles: [FileElement] = []
    ) -> [Target] {
        return targetTypes.reduce([]) { partialResult, targetType -> [Target] in
            var result: [Target] = []

            let targetSource: TargetType.TargetSource
            let testsTargetSource: TargetType.TargetSource?
            let product: Product

            switch targetType {
            case .staticLibrary(let _targetSource, let _testsTargetSource):
                targetSource = _targetSource
                testsTargetSource = _testsTargetSource
                product = .staticLibrary

            case .dynamicFramework(let _targetSource, let _testsTargetSource):
                targetSource = _targetSource
                testsTargetSource = _testsTargetSource
                product = .framework

            case .staticFramework(let _targetSource, let _testsTargetSource):
                targetSource = _targetSource
                testsTargetSource = _testsTargetSource
                product = .staticFramework
            }

            // Framework target
            let dynamicFrameworkTarget = Target(
                name: name,
                platform: platform,
                product: product,
                productName: productName,
                bundleId: "\(bundleIdReverseDomain).\(name)",
                deploymentTarget: deploymentTarget,
                infoPlist: infoPlist,
                sources: targetSource.sources,
                resources: targetSource.resources,
                copyFiles: copyFiles,
                headers: headers,
                entitlements: entitlements,
                scripts: scripts,
                dependencies: dependencies,
                settings: settings,
                coreDataModels: coreDataModels,
                environment: environment,
                launchArguments: launchArguments,
                additionalFiles: additionalFiles
            )
            result.append(dynamicFrameworkTarget)

            // Tests target
            if let testsTargetSource = testsTargetSource {
                let dynamicFrameworkTestsTarget = Target(
                    name: "\(name)Tests",
                    platform: platform,
                    product: .unitTests,
                    productName: productName?.appending("Tests"),
                    bundleId: "\(bundleIdReverseDomain).\(name)Tests",
                    deploymentTarget: deploymentTarget,
                    infoPlist: .default,
                    sources: testsTargetSource.sources,
                    resources: testsTargetSource.resources,
                    copyFiles: nil,
                    headers: nil,
                    entitlements: nil,
                    scripts: [],
                    dependencies: [
                        .target(name: name),
                    ] + testDependencies,
                    settings: settings,
                    coreDataModels: [],
                    environment: [:],
                    launchArguments: [],
                    additionalFiles: []
                )
                result.append(dynamicFrameworkTestsTarget)
            }

            return partialResult + result
        }
    }
}
