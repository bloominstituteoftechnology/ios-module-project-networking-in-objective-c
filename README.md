# Today's Weather - Part 2 (Networking in Objective-C)

Using the data that you parsed in the first part of the project. Today's first goal is to add networking to get the current weather for your devices GPS coordinate. With that fresh weather information you can update your app's UI to display the hourly forecast and daily forecast.

![Apple Weather app](https://tk-assets.lambdaschool.com/b75cb0a8-0706-4a47-81ab-6450283fedba_Apple-Weather.jpg)


## Instructions

1. Please continue from your previous fork. Create a new branch for `NetworkingUI`. 
2. Make a change, commit, and create your new Pull Request for today's assignment. 
3. Push your local changes regularly to Github so they appear on your Pull Request.
4. Submit your Pull Request along with your Module Project submission.

## Design Requirements

Your designer would like the app to show the daily weather and the weekly weather. It can be all on one screen, or you can use the Tab Bar to separate the screens (If you use a tab bar, use appropriate icons from SF Symbols). 

* Daily Weather View
	* Show the daily weather vertically (rows of data)
	* Display the following for each day of the week (including today):
		* Day of the week (i.e.: Monday)
			* Font: Title 3
			* Color: White
			* Left aligned
		* Weather icon
			* 40x40 points
		* Group Temperature
			* Spacing: 16 points
			* High temperature (i.e. 50)
				* Font: Title 3
				* Color: White
				* Separation: 16 point
			* Low temperature (i.e.: 30)
				* Font: Title 3
				* Color: 80% White (gray)
		* Row Height: ~62.5 points tall
		* Weather icon
* Hourly Weather View
	* Show the Hourly Forecast in a horizontal direction
	* Each "weather hour" should be vertical with the horizontal centers aligned
		* Time
			* Display the current hour (5PM) in the top of the cell ("Now" for the current)
			* Use the users current locale and timezone
		* Icon
			* 40x40 points
		* High temperature (i.e.: 30º)

## Technical Requirements 

* [Register and create a Dark Sky API account](https://darksky.net/dev) for access to the current weather.
* Read the [Dark Sky documentation](https://darksky.net/dev/docs) and request the current weather based on your devices current location.
* For your custom Table View Cell, use pin your view contents to the margins so that you get the correct spacing on the top, bottom, and sides.
* Use Equal Spacing for the primary Stack View for the layout in the Table View (if there's 3 elements it'll center your icon)
* Make sure you constrain the icon to 40x40, so it doesn't expand to it's intrinsic size of 130x130.
* For your custom Collection View Cell, make sure you add a subview for the "Content View" as the top most view, and then add your contents inside it. You'll need to pin this view to the edges with a constraint constant of 0 on all side
* Use container views if you are using a single screen to show the weather (embed your current weather and collection view controllers)

## Hints

* Use the `NSDateFormatter` to convert the date into a [day of the week (i.e.: Thursday)](https://nsdateformatter.com) for the devices current locale. 
* If you create a `UICollectionView` subclass using Xcode's template, **don't register a blank cell** in your `viewDidLoad` method (the default), it'll replace your design from your storyboard on start, leaving a blank collection view cell.


## Dark Sky API Requirements

* You must include a button that can display the text "Powered by Dark Sky", and it must be take users to the Dark Sky website: <https://darksky.net/poweredby/>


## Going Further

* Parse todays sunset and sunrise and display that in the hourly view content. (You may want another data structure to store the information as a single array). The data should be sorted based on the time.
* Add a toggle for military time and create a toggle in your settings app.
* Add a toggle for Fº or Cº in your settings app.
* Allow the user to add multiple locations (use reverse geocode lookup to search for a place), then make appropriate API calls.

