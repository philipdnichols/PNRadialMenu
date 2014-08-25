#PNRadialMenu

Trying my hand at creating a reusable radial menu in the style of the "myfitnesspal" radial menu button.

#Observations

My quick observations of the behavior of the radial menu in "myfitnesspal"

###Overall View
* The overall view fades to a semi-transparent black when the radial menu is being displayed, to better highlight the actual menu. Everything except the main menu button and the radial menu buttons are affected.
* The overall view unfades from a semi-transparent black when the menu is dismissed, either via regular dismissal or view a radial menu button item dismissal.
* Clicking on anything besides the main menu button and the radial menu buttons causes the radial menu to be dismissed the same as if the main menu button was tapped while the radial menu was being displayed.

###Main Button
* Main button is embedded in the tab bar of the app. There is also a sub-view behind the main menu button that gives a nice layered effect. This sub-view is darkened like the rest of the app when the radial menu is being displayed.
* Main button is a "+" sign round button.
* When the main button is pressed, it rotates counter-clockwise 45 degrees, becoming an "X" sign round button, which is convenient for showing that the button can now be pressed to dismiss the menu. The length of the animation appears to be around the same amount of time that all the menu animations take. Maybe a little bit off for some nice responsiveness trickery.
* When the main button is pressed while the radial menu is displayed, it rotates clockwise 45 degrees, reverting back to it's original state.

###Radial Menu
* When the radial menu is triggered for displaying, the radial menu buttons instantly fly outward to appear in an arc around the main menu button. The buttons appear from behind the main menu button when they first appear. The buttons reach a peak distance away from the main menu button and bounce/snap back into their final spots a few points closer to the main menu button than their maximum distance.
* When the radial menu is triggered for dimissing, the radial menu buttons, just for a split second, ease backward a few points (same distance as the maximum distance from the previous bulletpoint) from the main menu button before instantly snapping in toward the main menu button, becoming completely hidden.

###Radial Menu Buttons
* The radial menu buttons are approximately the same size as the main menu button.
* Each button is a flat solid solor with the actual icon being transparent within the circular button
* Below each button is a small text label, colored in the same manner as the button.
* During the display animation, the text labels are already present below the radial menu buttons.
* During the dismiss animation (not the radial menu button dismiss animations), the labels fade out completely during the backward ease before the buttons snap into the main menu button.
* When a radial menu icon is tapped, that individual icon and it's text label are scaled up in size and transparency is increased for a fraction of a second before the button disappears completely.
* When a radial menu icon is tapped, every other icon and it's text label are scaled down in size until they disappear completely.
* The previous 2 effects aren't always very apparent in the actual app because other windows and views instantly appear and cover up the radial menu, but it can be seen with good consitency when selecting the "Excersise" radial menu button.
* It is never apparent what happens to the main menu button when a radial menu button is tapped, but I think it is safe to assume that is behaves the same way a regular radial menu dismissal happens (I will be coding it this way.)
