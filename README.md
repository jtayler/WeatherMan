# WeatherMan
A test of swiftui

The type ahead search for new cities should be rewritten as a wrapper around a UIKit search text
iPad doesn't have a decent card style presentation for cities
Mac and iPad use split view poorly, modal view also splits on large screen devices?
The location can get confused, when you select no location and other edge cases
The city list should basically always have a selection and push before view, so you generally see the local city or whatever was last
Rotation needs at least minimal handling, views should react and dsiplay wide vs. tall using combine
Proper throttle and debounce so that fetches are limited, type-ahead is more responsive and the code is just cooler.
