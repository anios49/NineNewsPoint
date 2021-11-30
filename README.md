# NineNewsPoint
## Implementation info
 * Please go through the README.md file
 
 * Please review the documents folder for screenshots, class diagrams, code coverage and app videos.
 
 * Application code is written in NineNewsPoint.
 
 * Created the seprate library for NineNewsPointServices. which contain all functionality that could be reused by 3rd party developers in any application that requires news list data.
 
 * Used XCode 12.4 with Swift 5. 

## Application Run & Compile steps
* Clone source code.

* Open NineNewsPoint.xcodepoj.

* Build the NineNewsPointService framework.

* Change target to NineNewsPoint and run the application

## Screenshots
![1](https://user-images.githubusercontent.com/43500940/143995180-97c4e193-9fcd-4579-b12b-c82137904019.PNG).    ![1](https://user-images.githubusercontent.com/43500940/143995287-f24974b3-f9e9-44b0-bb4c-3dc6c5d611b9.PNG)


## Task

The included API endpoint returns, amongst other data, an array of news stories (assets).

You are tasked with creating an iPhone app that consumes the provided API and displays a list of news articles to the user, ideally in a TableView or CollectionView (UIKit). Tapping a story should present the asset’s URL in a WKWebView or an alternate.

## Requirements

* The list of articles should display at least the following fields:

-- headline

-- theAbstract

-- byLine

✅ @Animesh - Followed the same. Also added date and time.



* Display the latest article first in the list, use article's 'timeStamp'

✅ @Animesh - Sorted the list of article. 

```self.assets?.sort(by: { $0.timeStamp > $1.timeStamp})```



* If an 'asset' has 'relatedImages', display the smallest image available as a thumbnail on the cell

✅ @Animesh - Implemented the same on the basis of image area.

```images?.sort(by: { ($0.width * $0.height) < ($1.width * $1.height) })```



* Images should be loaded asynchronously and cached

✅ @Animesh - Done.



* The style of cells is up to you, with necessary padding and layout.

✅ @Animesh - Done, Custom collection view cell created.



* For UI use storyboards, xibs or layout programmatically as needed, but it should adapt to all iPhone screen sizes

✅ @Animesh - Done.



* Comment your code, so it's understandable in six months

✅ @Animesh - Done.



* Make sure to include Unit tests as part of the solution - we thoroughly review unit tests and coverage!

✅ @Animesh - Done, for NineNewsPointService coverage is 94.4% & for NineNewPoint app coverage is 86.4%.

![CodeCoverage](https://user-images.githubusercontent.com/43500940/143993267-4d455203-688c-4ec4-8391-2716c1124453.png)

![UnitTestCases](https://user-images.githubusercontent.com/43500940/143993419-5a7008ae-b734-470a-a139-f55ac3a2a792.png)



* Add at least two UI tests to verify UI is functional and/or cover some important user flow

✅ @Animesh - Done, Added user flow and componets UI tests.



* Use Xcode 12.x (stable) with Swift 5, please specify code compilation notes in your submission.

✅ @Animesh - Used XCode 12.4 with Swift 5.



Please feel free to ask if you have any questions interpreting this document!


### Bonus

* Using CollectionView implementation instead TableView for the list of articles

✅ @Animesh - Used the CollectionView.



## Submission Notes

* Code Compilation instructions for the IDE/Plugin expected, dependency management, etc

✅ @Animesh - NineNewsPoint is a framework, which needs to be plugin while use.



* Short description explaining architecture (e.g View, ViewModel...)

✅ @Animesh -  Model-View-ViewModel architechture is used. I have added the class diagram in the document folder.



* Any 3rd party libraries used and rational

✅ @Animesh -  No use of third party libraries.



* Explain what each test does in comments or in a document format

✅ @Animesh -  Added comments in unit test code.



* Explain any additional features covered - apart the requirements given above

✅ @Animesh -  Added the feature to share the News with your friends or family using UIActivityViewController.

✅ @Animesh -  DarkMode support.

✅ @Animesh -  Pull to refresh.


* Please either share your repository (public repo preferred) or use a service like Dropbox to share the file.



## How we evaluate

We want you to succeed! We aim to evaluate each submission with the same criteria, they are:

 * *requirements* you've build the right product, attention to details!

 * *code architecture* appropriate design patterns used (MVVM, MVP ...) - we use MVVM in-house

 * *code style* idiomatic, safe, clean, concise.

 * *unit tests* coverage, stable, reliable, maintainable, mocked where required

 * *user experience* responsive, user-centric design.

## Resources

API Endpoint:

https://bruce-v2-mob.fairfaxmedia.com.au/1/coding_test/13ZZQX/full

