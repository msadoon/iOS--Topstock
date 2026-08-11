# topstock-iOS

 ![frontend for topstock](/Public/topstock_icon.png "app logo")

[backend server](https://github.com/msadoon/topstock)

## Features Todo

**General UI/UX**
- [ ] Put it logos for data providers (alpaca, logos.dev - link to them).
- [x] Ensure graph is shown completely when modal first appears.

**Historical Bars**
- [x] Ensure graph is scrollable (dates/times are shown correctly while scrolling)
- [ ] Animate graph changes between time frames.
- [x] X-axis should contain date, times should be clock-based, Y-axis in $USD, Improve graph grid lines.
- [ ] Paging while scrolling. (Think more about this.)

**Data**
- [ ] Logos and historical bar data should be cached and retrieval from cache before hitting the network.

**Deployment**
- [ ] Setup Fastlane. 

**Authentication**
- [ ] Work on after all other features. Configure with JWT authentication on the server.

**Bugs**
- [ ] Look into overlays for the date, ticker symbol and currency displays.
