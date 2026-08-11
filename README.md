# topstock-iOS

 ![frontend for topstock](/Public/topstock_icon.png "app logo")

[backend server](https://github.com/msadoon/topstock)

## Features Todo

**General UI/UX**
- [ ] Put it logos for data providers (alpaca, logos.dev - link to them).

**Historical Bars**
- [ ] Add annotations to each mark on the chart so a candlestick can be drawn as a pop-up.
- [ ] Historical bars supports todays date just fifteen minutes back, make the change to pull in the last available days data, displaying it, then paging backward. No need for latest bars, until we can incorporate it without gaps in the timeline.
- [ ] Animate graph changes between time frames.
- [ ] Paging while scrolling. (Think more about this.)

**Data**
- [ ] Logos and historical bar data should be cached and retrieval from cache before hitting the network.

**Deployment**
- [ ] Setup Fastlane. 

**Authentication**
- [ ] Work on after all other features. Configure with JWT authentication on the server.

**Bugs**
- [ ] Look into overlays for the date, ticker symbol and currency displays.
