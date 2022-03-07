<!-- New Page Creation Instruction -->
  1 : Every Page need to inhert MyCallBack ,Common classes

<!-- Page Navigation Type (Event Name: typeOfNavigation)-->
  1 : Navigate to next Screen without Pop Previous Screen
  2 : Navigate to next Screen  Popping all  Previous Screen
  3 : Pop Current Page
  4 : Close last 2 Pages
  default :  Navigate to next Screen without Pop Previous Screen

<!-- General Class -->
  Contains Page Identifiers, function for creation output Data Json

<!-- Common Class  -->
  Contains functions for TapEvents

<!--Common Click Event Names -->
Navigation
FormSubmit
OpenDrawer
navigateToPage
typeOfNavigation
actionType
openMap
formDataJson_ApiCall
ChangeValues
changeValuesArray


<!-- v-0.0.2 -->
22-2-2022
1. compare to function


25-02-2022
1.added opacity Controller
2. added compareTo validation in inputBox
3.added customPopUp

26-02-2022
1. added sliver (need to change custom scrollView)
2. added reloadPage in MyCallBack


27-02-2022
1.added expansionTile Controller
2. new event fromListView, key:"parentListViewKey"
3. getValueByIndex function in listview Controller

28-02-2022
added slivers

01-03-2022
1. added opacity in button(container)

<!-- v-0.0.3 -->
1. tabbar controller changes:
        added pageviewWidget for avoid recursion
2. pageview controller changes:
        added tabbarWidget for avoid recursion
        added timer to jumpto page 1

3. added intrinsic controller
4. reduced width in Text and button
5. added rating bar
6.listview controller timer added in updateValue

7. changes dine in updateByWidgetType function <!-- Important -->
8. swipe to delete


added customPopUp empty value