import SwiftUI

// MARK: - 版本兼容扩展（iOS 16.0 部署目标）

extension Color {
    /// iOS 16 兼容：`Color.opacity(_:)` 在 iOS 17 SDK 中标注为 17+，
    /// 通过 UIColor alpha 构造实现同样效果（iOS 15+ 可用）。
    func compatOpacity(_ opacity: Double) -> Color {
        Color(UIColor(self).withAlphaComponent(CGFloat(opacity)))
    }
}

extension View {
    /// `presentationBackground` 需要 iOS 16.4；更低版本保持默认背景。
    @ViewBuilder
    func compatPresentationBackground<S: ShapeStyle>(_ style: S) -> some View {
        if #available(iOS 16.4, *) {
            self.presentationBackground(style)
        } else {
            self
        }
    }
}

/// iOS 16 兼容版 `ContentUnavailableView`。
/// iOS 17+ 直接使用系统实现，iOS 16 用相同层级的 VStack 自绘兜底。
struct CompatUnavailableView<Actions: View>: View {
    let title: String
    let systemImage: String
    var description: Text?
    @ViewBuilder var actions: () -> Actions

    init(
        _ title: String,
        systemImage: String,
        description: Text? = nil,
        @ViewBuilder actions: @escaping () -> Actions = { EmptyView() }
    ) {
        self.title = title
        self.systemImage = systemImage
        self.description = description
        self.actions = actions
    }

    var body: some View {
        if #available(iOS 17.0, *) {
            systemContent
        } else {
            legacyContent
        }
    }

    @available(iOS 17.0, *)
    private var systemContent: some View {
        ContentUnavailableView(
            title,
            systemImage: systemImage,
            description: description
        )
    }

    private var legacyContent: some View {
        VStack(spacing: 10) {
            Image(systemName: systemImage)
                .font(.system(size: 44, weight: .light))
                .foregroundStyle(.secondary)
            Text(title)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
            if let description {
                description
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            actions()
        }
        .padding(24)
        .frame(maxWidth: .infinity)
    }
}
