# iOS15-SwiftUI-InAppPurchaseDemo
In-App Purchase Demo app written with SwiftUI

If you want to try it for yourself, follow these steps.

1. Open StoreViewModel file
2. Change com.premium.world1 to a uniqueString
let products = try await Product.products(for: ["com.premium.world1"])

3. Open Configuration file
4. Change productID to the uniqueString in step 2

5. Deploy and try.
6. You have to change uniqueString every time because it's a non-consumable In-App Purchase

Gif

![In-App Purchase Demo](https://user-images.githubusercontent.com/32461567/153755550-1c6904b2-cbbb-4d77-8a79-20c8c35ed181.gif)
