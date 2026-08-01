# topstock-iOS

 ![frontend for topstock](/Public/topstock_icon.png "app logo")

[backend server](https://github.com/msadoon/topstock)

## Features Todo

**General UI/UX**
- [x] Design the app layout for the market movers and historical bars.
- [ ] Implement list view UI/UX.
- [ ] Implement detail view UI/UX

*bugs*
- [ ] Fix display issues on list view
- [ ] Ensure list view loads for iOS 18.4+ on first install (including images).
- [ ] Put it logos for data providers (alpaca, logos.dev)
- [ ] Clean up cell spacing for list view.

**Historical Bars**
- [ ] This is complicated UI. Scrollable candle stick bars for each day. May require paging on the backend. SwiftCharts.

**Networking**
- [x] Setup networking to hit all endpoints.
- [x] Test networking.

**Deployment**
- [ ] Setup Fastlane. 

**Authentication**
- [ ] Work on after all other features. Configure with JWT authentication on the server.

**Security**
- [ ] Ensure HTTPS is being used. Ie. no arbitrary loads.

