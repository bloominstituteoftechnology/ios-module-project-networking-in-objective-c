# Today's Weather (2 day project)

## Introduction

You will be creating a weather app that can update based on the current conditions. You will be parsing JSON that provides current, daily, hourly forecast information for a location.

## Instructions

1. Please fork and clone this repository. (It contains a starter project with the storyboard and asset catalog)
2. Make a change, commit, and create your Pull Request.
3. Push your local changes regularly to Github so they appear on your Pull Request.
4. Submit your Pull Request along with your Module Project submission.

## Part 1: Design Today's Weather

![Today's Weather](https://tk-assets.lambdaschool.com/19e93a70-2966-471a-9183-326aab2d97b9_WeatherApp-Objective-C.png)

1. You will be making an app that looks like the Today's Weather screenshot. 
2. Included in the project is an Asset Catalog with all the weather images you will need for this project.

## Design Hints

Your designer sketched out the requirements for the fonts, colors, and spacing on a notepad. They want you to try and match the screenshot as much as possible.

![Designer UI Hints](https://tk-assets.lambdaschool.com/6746bb60-c92c-46d2-ae7d-928a40e13099_Todays-Weather-UI-markup.JPG)


### Customer Requirements

Design Requirements are as follows:

#### Quick Look: Top View

* "Top View" is 40% height of iPhone screen (Use equal height to superview with 0.4 multiplier)
	* No white bars on iPhone X style devices
	* Edge to edge color (0 point margins)
	* Color: System Blue
* "Quick Look" view content inside "Top View"
	* Centered vertically and horizontally in "Top View"
	* Icon: 64x64 point size
	* "City, State" label
		* Font: Title 1
		* Color: White
	* "Summary" label
		* Font: Body
		* Color: White
	* "Temperature" label
		* System Light, 60 points
		* Color: White
	* Icon, "City, State", and "Summary" views should be 0 points vertical spacing
	* "Temperature" should be 16 points away from "Summary" 

#### Detailed Conditions: Bottom View

* 60% height of the iPhone screen (fill remaining space below top view)
	* Edge to edge color (0 point margins)
	* Color: HEX: `0057B6`
	* Light style Home indicator
* Weather "Details Views"
	* Title
		* ALL CAPS
		* Font: System Footnote
		* Color: 80% white (gray)
	* Value
		* Include appropriate units (mph, º, %, and inHg)
		* Font: Title 1
		* Color: White
	* Spacing
		* Inset 20 points horizontally on left/right margins
		* Inset 20 points vertically from top of "Bottom View"
		* Both Title and Value are leading text layout (left edge)
		* Detail Views are 50% screen width (minus the 40 constant from left/right margins)
		* Detail Views are equal width

#### Toolbar and Settings View Controller

1. You must include a info button (SF Symbol: "info.circle.fill") that can display a Settings Table View Controller in the bottom right corner
	2. The "Settings Table View Controller" must have a navigation title: "Settings" (Embed it in a navigation controller)
	3. The first cell must display "Today's Weather v.1.0"
	4. The second cell must display "Powered by Dark Sky", and it must be take users to the Dark Sky website: <https://darksky.net/poweredby/>
2. The toolbar must be transparent along the bottom of the screen. (See [this developer hint](https://stackoverflow.com/a/18969325/276626))

## Part 2: Data Modeling in Objective-C

Parse the data for the weather from a JSON file.

### Technical Requirements

Create model objects to parse the data into the following model objects.

NOTE: Make sure you choose a location for your Simulator if you don't test this on a device, since you won't get a location until you do.

#### Starter Project

Your team lead created a starter project with the icons, helper files, and location services so that you can focus on the weather.

Review the provided files before you begin.

#### Current Weather

1. [Review the APIs value types](https://darksky.net/dev/docs#data-point) (and if they are optional) for the required fields.

2. Parse the "CurrentWeather.json" file and verify it works in your Unit Test.

	Create a model object: `LSIWeatherForcast` with a child CurrentForecast object 
	
	**Required Fields**
	
	* `time` (unix time)
	* `summary`
	* `icon`
	* `precipProbability`
	* `precipIntensity`
	* `temperature`
	* `apparentTemperature` (Feels like)
	* `humidity`
	* `pressure`
	* `windSpeed`
	* `windBearing`
	* `uvIndex`

3. After parsing the "CurrentWeather.json", update the UI using the model object.
	1. Use the LSIWeatherIcons.h to load the correct icon (? if missing)
	2. Use LSICardinalDirections.h to convert wind direction (bearing) from 30º to NE.
	3. Parse the model in the LSIWeatherViewController.m when you "fetch the weather" (Look for the `TODO:`), tomorrow you'll update this to do the actual weather requests.

#### Daily Weather

1. Parse the "DailyWeather.json" file and verify it works in your Unit Test.

2. Parse each day as an: `LSIDailyForecast`

	* `time` (unix time)
	* `summary`
	* `icon`
	* `sunriseTime`
	* `sunsetTime`
	* `precipProbability`
	* `precipIntensity`
	* `precipType` ("rain", "snow", or "sleet", or nil)
	* `temperatureLow`
	* `temperatureHigh`
	* `apparentTemperature` (Feels like)
	* `humidity`
	* `pressure`
	* `windSpeed`
	* `windBearing`
	* `uvIndex`

#### Hourly Weather

1. Parse the "HourlyWeather.json" file and verify it works in your Unit Test
2. Parse each object in the array as an `LSIHourlyForecast` object

	**Required Fields**
	* `time` (unix time)
	* `summary`
	* `icon`
	* `precipProbability`
	* `precipIntensity`
	* `precipType` ("rain", "snow", or "sleet", or null)
	* `temperatureLow`
	* `temperatureHigh`
	* `apparentTemperature` (Feels like)
	* `humidity`
	* `pressure`
	* `windSpeed`
	* `windBearing`
	* `uvIndex`

3. Some fields are optional and are dependent on values in other fields. Make sure you [read the documentation](https://darksky.net/dev/docs#data-point).

### Weather 

1. Parse the "Weather.json" and store the properties

	* `currently`
	* `daily`
	* `hourly`

2. Refactor your logic to update Today's Weather using the "Weather.json" 

### Use Helper Functions




## Going Further

* Add visibility (miles) and dewPoint and display them with the appropriate units.
* Display the sunrise and sunset times (use icons in Asset Catalog)
* Change the units displayed from Cº to Fº, mph to kph etc. (see API documentation)


