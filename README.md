## Face Detector & Face Classifier

Skeleton code was provided for this assignment to implement a face detector and face classifier using Matlab. The technical writeup focuses on the creation and subsequent optimisation of a basic face detector & classifier (as part of [CM30080](http://www.bath.ac.uk/catalogues/2016-2017/cm/CM30080.html): *Computer Vision*).

Graded as a first.

![alt text](http://i.imgur.com/ydxv9NM.png)


### Face Detector
* Working from the Skeleton code, a sliding normalisation technique was implemented to achieve a basic detection rate of ~21% with a template image.
* Breadth-based exploration into increasing the detection rate including:
  * Isolating RGB channels
  * Edge detection with weak and strong edges
  * Optimising edge detection by reducing vertical lines and tuning threshold parameters
  * Additional Guassian kernels for noise reduction
  * Non-maximal surpression tuning
* The improved detector raises the detection rate to ~68% using basic template matching.

### Face Classifier
* Implementation of the nearest-neighbour algorithm for basic classification using validation data.
* Z-score and other normalisation techniques to double the classification rate.
* Discussion on Support Vector Machines, Naive Bayes, and the [Hungarian Algorithm](https://en.wikipedia.org/wiki/Hungarian_algorithm) for extending the classifier.

Full writeup included in the technical report.

