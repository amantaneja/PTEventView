
<center><img src="https://github.com/amantaneja/PTEventView/blob/master/Images/PTEventViewTitle.png"></center><br>
An Event View based on Apple's Event Detail View. Written in Swift 3. Supports ARC, Autolayout and editing via StoryBoard.

![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)
![Platform](https://img.shields.io/badge/Platforms-iOS-red.svg)
![Swift 3.x](https://img.shields.io/badge/Swift-3.x-blue.svg)
![MadeWithLove](https://img.shields.io/badge/Made%20with%20%E2%9D%A4-India-green.svg)

<img src="https://github.com/amantaneja/PTEventView/blob/master/Images/PTEventViewDemo.gif" >

# Installation
### CocoaPods
The project is uploaded on CocoaPods and will available for downloading soon. <br>
http://cocoadocs.org/docsets/PTEventView/0.2.0/


### Carthrage
The project will be available on Carthrage too. [As soon as I learn how to do it. ;) ]<br>

### Manual
You can drag and drop the Files from [here](https://github.com/amantaneja/PTEventView/tree/master/Demo/PTEventViewDemo/PTEventView) into your projects directly. 

# Setup
### Adding PTEventView

```swift
fileprivate weak var myCalenderView: PTEventView!
```
```swift
// In loadView or viewDidLoad
let ptEventView = Bundle.main.loadNibNamed("PTEventView", owner: nil, options: nil)![0] as? PTEventView
ptEventView?.delegate = self
ptEventView?.setup(frame: myCalenderView.frame)
self.view.addSubview(ptEventView!)
```

### Data Model
PTEventView supports both 12 hour and 24 hour format as data model. The input can be received from the API or Database(Core Data, Realm, SQLite) in the form of Array of `Event Object`.<br>
The Event Object should have:
- Start Time (12 hour or 24 hour)
- End Time (12 hour or 24 hour)
- Name of the Event <br>
**Note**: Incase of 12 hour, suffix time with AM or PM.<br>

**Example** 
```swift
let dataModel12hour = [["10AM","11AM","Swift Meetup '17"],["12AM","3PM","WWDC KickOff"]]
let dataModel24hour = [["10","11","Swift Meetup '17"],["12","15","WWDC KickOff"]]
```
Use Bool to switch between Time Formats
```swift  
ptEventView?.is24HourFormat = true
```
```swift
for event in dataModel12hour{
            
    let eventModel = PTEventViewModel()
    
    eventModel.startTime = event[0]
    eventModel.endTime = event[1]
    eventModel.eventName = event[2]
    
    ptEventView?.EventViewdataModel.append(eventModel)
}
```


# StoryBoard
Supports IBDesignable to alter `Border Width`, `Corner Radius` and `Border Color`
<img src="https://github.com/amantaneja/PTEventView/blob/master/Images/IBDesignable.png" height="220" width="370">

### Customization
You can customize the view parameters for designing your own view:

`borderColor` **- Border Color** *Default is Black*

`borderWidth` **- Border Width** *Default is 1.0*

`cornerRadius` **- Corner Radius** *Default is 6.0*

`eventColor` **- Event Color** *Default is as given in Demo Gif*

`eventTextColor` **- Event Text Color** *Default is white. Try to make it contrasting with eventColor*

# ToDo[s]
- [x] Add support for PM and AM via 24 hour format
- [ ] Orientation Support. Currently supports UI for Portrait.
- [x] Add delegation for callbacks
- [ ] Implement AutoLayout for CalenderView
- [ ] Support Events on the same day
- [ ] Add IBInspectable for Row Color of Event


## License

PTEventView is released under the MIT license. See [LICENSE](https://github.com/amantaneja/PTEventView/blob/master/LICENSE) for details.
