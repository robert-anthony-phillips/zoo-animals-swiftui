Zoo Animals SwiftUI
==================================

A small example app that connects to https://zoo-animal-api.herokuapp.com and displays random animals and their associated stats.

All code uses US spelling.

## Welcome View

The app opens to a welcome view that prompts the user to select how many animals to display. Because the API only supports a maximum of 10, I chose to use a segmented control to make it clear that the choice is between 1 and 10. Tapping SAVE saves the option to the settings repository and swaps to the animal list view.

## List View

The animal list view lists the the animals as specified with a refresh button and settings button in the navigation bar. I intentionally chose to refresh the display on press of refresh without asking the user again for the number as I consider it better UX. The user has the option to change the refresh value by accessing settings. Settings is accessible from both the list view and detail view.

I intentionally chose to keep the thumbnail images the same size for each row as I like the uniformity. As some of the images are portrait, the thumbnail images are top aligned so that the head of the animal appears within the frame.

Tapping a row takes the user to the detail view.

## Detail View

The detail view shows a picture of the animal and the stats as specified.

The user can access the settings view from the cog button in the navigation bar. Changing the unit preferences and dismissing the settings view will update the detail view instantly.

## Settings View

The settings view is presented as a sheet and can be dismissed with a swipe or close button.

The number of random animals to display, length unit and weight unit can be changed via the use of segmented controls.

I intentionally did not add a save button as the choice is saved automatically for the user and is better UX, IMHO.

I intentionally used length and not height as specified in the requirements. I did this because the values specified in the DTO from the server are length values.

## Improvements

If I'd had more time I would like to have added more tests. However, I feel that the tests I have added demonstrate a good understanding of testing and how I would normally write them.

I'm new to SwiftUI but notice that the navigation links are tightly coupled to the view. I would therefore have liked to have learned more about SwiftUI navigation best practices and if I could have applied them to this example.
