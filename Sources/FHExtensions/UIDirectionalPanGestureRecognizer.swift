#if canImport(UIKit)
import UIKit

/// A concrete subclass of **UIPanGestureRecognizer** that cancels if the specified direction does not match.
///
/// - Important: The `touchesMoved(_:with:)` is not called on trackpad and mouse events.
/// Use the `UIGestureRecognizerDelegate.gestureRecognizerShouldBegin(_:)` instead if the `allowedScrollTypesMask` is set to `UIScrollTypeMask.discrete` or `UIScrollTypeMask.continuous`.
public class UIDirectionalPanGestureRecognizer: UIPanGestureRecognizer {
    
    /// The direction of the `UIDirectionalPanGestureRecognizer`.
    public enum Direction {
        case horizontal
        case vertical
    }
    
    /// The allowed pan direction.
    ///
    /// The default value is `Direction.horizontal`.
    public var direction: Direction = .horizontal
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        if state == .began {
            let velocity = self.velocity(in: view)
            switch direction {
            case .horizontal where abs(velocity.y) > abs(velocity.x):
                state = .cancelled
            case .vertical where abs(velocity.x) > abs(velocity.y):
                state = .cancelled
            default:
                break
            }
        }
    }
}

#endif
