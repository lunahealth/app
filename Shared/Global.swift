import Archivable
import CloudKit
import Selene

let cloud = Cloud<Archive, CKContainer>.new(identifier: "iCloud.moonhealth")

#if os(iOS)
var store = Store()
#endif
