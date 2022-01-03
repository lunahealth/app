import Archivable
import Selene

let cloud = Cloud<Archive>.new(identifier: "iCloud.moonhealth")

#if os(iOS)
let store = Store()
#endif
