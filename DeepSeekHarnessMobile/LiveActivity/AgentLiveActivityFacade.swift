import Foundation

/// Live Activity 的版本门面。
/// iOS 16.1+ 把调用转发给 ActivityKit 实现；更低版本静默忽略，
/// 让主 App（部署目标 16.0）无需在每个调用点写 `#available`。
@MainActor
final class AgentLiveActivityFacade {
    static let shared = AgentLiveActivityFacade()

    @available(iOS 16.1, *)
    private var impl: AgentLiveActivityManager? {
        AgentLiveActivityManager.shared
    }

    func applicationDidBecomeActive() {
        if #available(iOS 16.1, *) { impl?.applicationDidBecomeActive() }
    }

    func refreshActiveActivities() {
        if #available(iOS 16.1, *) { impl?.refreshActiveActivities() }
    }

    func sessionStarted(
        gatewayID: String,
        sessionID: String,
        title: String,
        turn: Int?,
        sourceLabel: String? = nil
    ) {
        if #available(iOS 16.1, *) {
            impl?.sessionStarted(gatewayID: gatewayID, sessionID: sessionID, title: title, turn: turn, sourceLabel: sourceLabel)
        }
    }

    func stepStarted(
        gatewayID: String,
        sessionID: String,
        title: String,
        step: Int?,
        sourceLabel: String? = nil
    ) {
        if #available(iOS 16.1, *) {
            impl?.stepStarted(gatewayID: gatewayID, sessionID: sessionID, title: title, step: step, sourceLabel: sourceLabel)
        }
    }

    func progressUpdated(
        gatewayID: String,
        sessionID: String,
        title: String,
        headline: String,
        detail: String?,
        kind: AgentActivityStepKind,
        toolName: String? = nil,
        sourceLabel: String? = nil
    ) {
        if #available(iOS 16.1, *) {
            impl?.progressUpdated(
                gatewayID: gatewayID,
                sessionID: sessionID,
                title: title,
                headline: headline,
                detail: detail,
                kind: kind,
                toolName: toolName,
                sourceLabel: sourceLabel
            )
        }
    }

    func toolStarted(
        gatewayID: String,
        sessionID: String,
        title: String,
        toolName: String?,
        sourceLabel: String? = nil
    ) {
        if #available(iOS 16.1, *) {
            impl?.toolStarted(gatewayID: gatewayID, sessionID: sessionID, title: title, toolName: toolName, sourceLabel: sourceLabel)
        }
    }

    func awaitingApproval(
        gatewayID: String,
        request: GatewayPendingApprovalRequest,
        title: String,
        command: String?,
        sourceLabel: String? = nil
    ) {
        if #available(iOS 16.1, *) {
            impl?.awaitingApproval(
                gatewayID: gatewayID,
                request: request,
                title: title,
                command: command,
                sourceLabel: sourceLabel
            )
        }
    }

    func awaitingChoice(
        gatewayID: String,
        request: GatewayPendingQuestionRequest,
        title: String,
        prompt: String?,
        sourceLabel: String? = nil
    ) {
        if #available(iOS 16.1, *) {
            impl?.awaitingChoice(
                gatewayID: gatewayID,
                request: request,
                title: title,
                prompt: prompt,
                sourceLabel: sourceLabel
            )
        }
    }

    func choiceResolved(
        gatewayID: String,
        sessionID: String,
        rpcID: String,
        cancelled: Bool,
        title: String
    ) {
        if #available(iOS 16.1, *) {
            impl?.choiceResolved(
                gatewayID: gatewayID,
                sessionID: sessionID,
                rpcID: rpcID,
                cancelled: cancelled,
                title: title
            )
        }
    }

    func enrichApprovalCommand(
        gatewayID: String,
        sessionID: String,
        rpcID: String,
        command: String?
    ) {
        if #available(iOS 16.1, *) {
            impl?.enrichApprovalCommand(
                gatewayID: gatewayID,
                sessionID: sessionID,
                rpcID: rpcID,
                command: command
            )
        }
    }

    func sessionTitleUpdated(gatewayID: String, sessionID: String, title: String) {
        if #available(iOS 16.1, *) {
            impl?.sessionTitleUpdated(gatewayID: gatewayID, sessionID: sessionID, title: title)
        }
    }

    func approvalSubmitting(
        gatewayID: String,
        sessionID: String,
        request: GatewayPendingApprovalRequest,
        outcome: GatewayApprovalOutcome,
        title: String,
        command: String?,
        sourceLabel: String? = nil
    ) {
        if #available(iOS 16.1, *) {
            impl?.approvalSubmitting(
                gatewayID: gatewayID,
                sessionID: sessionID,
                request: request,
                outcome: outcome,
                title: title,
                command: command,
                sourceLabel: sourceLabel
            )
        }
    }

    func approvalResolved(
        gatewayID: String,
        sessionID: String,
        rpcID: String,
        outcome: GatewayApprovalOutcome,
        title: String
    ) {
        if #available(iOS 16.1, *) {
            impl?.approvalResolved(
                gatewayID: gatewayID,
                sessionID: sessionID,
                rpcID: rpcID,
                outcome: outcome,
                title: title
            )
        }
    }

    func approvalFailed(
        gatewayID: String,
        sessionID: String,
        rpcID: String,
        title: String,
        reason: String?,
        sourceLabel: String? = nil
    ) {
        if #available(iOS 16.1, *) {
            impl?.approvalFailed(
                gatewayID: gatewayID,
                sessionID: sessionID,
                rpcID: rpcID,
                title: title,
                reason: reason,
                sourceLabel: sourceLabel
            )
        }
    }

    func sessionEnded(
        gatewayID: String,
        sessionID: String,
        title: String,
        failed: Bool,
        sourceLabel: String? = nil
    ) {
        if #available(iOS 16.1, *) {
            impl?.sessionEnded(
                gatewayID: gatewayID,
                sessionID: sessionID,
                title: title,
                failed: failed,
                sourceLabel: sourceLabel
            )
        }
    }

    func reconcileSessions(gatewayID: String, runningBySessionID: [String: Bool]) {
        if #available(iOS 16.1, *) {
            impl?.reconcileSessions(gatewayID: gatewayID, runningBySessionID: runningBySessionID)
        }
    }
}
