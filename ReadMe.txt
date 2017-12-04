README

Version 1.0
Operating Environment: matLab2017b
Required package: Neural Network Toolbox & Computer Vision Toolbox


*****Summary*****

Training Neural Network requires a large set of images, yet it is our biggest problem. If trained with Convolutional Neural Network we might need a GPU engine. We can still train it using a CPU but it will take longer. 

Therefore after extensive researches, I learned that computer visioning could also realize our goal. Using online tutorial from MathWorks, I built two preliminary models OrchaVision and OrchaSearch.


*****OrchaVision*****

OrchaVision uses computer vision and machine learning to classify images. So far it has a 90% success rate.
For more details feel free to watch this video about Computer Vision: https://www.mathworks.com/videos/working-with-large-sets-of-images-in-matlab-just-got-easier-100490.html


*****OrchaSearch*****

OrchaSearch also uses computer vision to detect features of your input and search for similar objects in another image. I�m still testing it but so far my tune works well. I can load a snippet of “For Elise” with different signatures and the program can locate where it is in another version of the “For Elise”

Next Step in OrchaSearch:
Identify one snippets among many music sheets. Output the music sheets with the highest match.

To Do and Question:
How do we incorporate Neural Network in it?


