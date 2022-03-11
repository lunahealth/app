import Foundation

enum Copy {
    static let noPurchases = """
No In-App Purchases available at the moment, try again later.
"""
    
    static let location = """
Choose your location
to follow the Moon
"""
    
    static let notifications = """
**Moon Health** uses notifications to display important messages and provide feedback to your actions, and only when you are actively using the app and will never send you Push Notifications.
"""
    
    static let privacy = """
This app is **not** tracking you in anyway, nor sharing any information from you with no one, we are also not storing any data concerning you.

We make use of Apple's *iCloud* to synchronise your data across your own devices, but no one other than you, not us nor even Apple can access your data.

If you allow **notifications** these are going to be displayed only for giving feedback on actions you take while using the app, we **don't** want to contact you in anyway and specifically we **don't** want to send you **Push Notifications**.

Whatever you do with this app is up to you and we **don't** want to know about it.
"""
    
    static let froob = """
**Moon Health** is brought to you free by an **indie** team and with **The Dark Side of the Moon** you can support its development and improvement.

This is a non-consumable In-App Purchase, but it is _optional_, you can keep using the app even without it.
"""
}
