#if canImport(UIKit)
import UIKit

/// A concrete subclass of UIPanGestureRecognizer that looks for panning (dragging) gestures in the setted direction.
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
            let velocity = velocity(in: view)
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
