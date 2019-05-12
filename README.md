# P300-Speller
Hello Everyone. Here I would like to show a project, that describes the process of development a Brain Computer Interface (BCI) that can help people interact with surroundings, using only their thoughts with the application called P300 Speller.

P300 Speller is an application that allows people spell words and display them on the screen by using only the power of thoughts. It uses visual stimulation, meaning that when we focus on specific visual stimuli, our brain produces specific patterns. Those patterns appear in our brain approximately after 300ms after presentation. So, this is basically a delayed response in our brain. This phenomenon is called P300. The application itself represents a matrix that consists of letters and numbers. Rows and columns are randomly highlighted with the interval of 100ms each. The subject is nicely asked to focus his attention on just one letter, and once the desired letter is highlighted the signal goes through the occipital lobe of your brain. EEG cap captures that activity and sends it to computer. Then classification algorithm is used to choose the correct result. Once it’s done, the letter subject was focusing on appears on the screen. And so the process is repeated, letter by letter, until the whole word is formed. The reason why rows and columns are highlighted randomly and not consecutively is that the best way to initiate a P300 wave in your brain is to excite it, meaning that if your brain doesn’t know which row or column is flashed next, then it won’t get used to it. 

  This is how the P300 Speller looks like:

  <a href="https://imgflip.com/gif/30rktl"><img src="https://i.imgflip.com/30rktl.gif" title="made at imgflip.com"/></a>

While designing the application I've noticed that most of the research papers that I’ve read had  the same standard: keep rows and columns flashed for 100ms, and the gap of 75ms between them. I’ve used 15 iterations for every row and column (12), which would give me 180 flashing for a single character. After the user clicks the start button, the target letter that I need to focus on gets highlighted in blue for 4 seconds before everything starts flashing. This feature is used to keep the user from forgetting the next letter he/she has to focus on. After that the flashings begin. Every time your target letter is flashed it creates a P300 wave in your brain. Everything else that is being flashed is considered to be a non-target wave. 

### For the first 2 steps, all the scripts are located in P300_Speller_Train folder

# Step 1: Data Collection and Data Preprocessing
## Data Colection

First of all we need to record the brain signals to train computer to be able to distnguish between target P300 and non-target brain waves. There are multiples ways to do that. The one I’ve used is called Electroencephalogram or EEG for short. It is an activity of acquiring brain waves from a scalp. The way it works, is that the subject places the EEG cap on the scalp, and the electrodes detect the electrical activity in the brain.

EEG cap that I’ve used through all this time is called [EMOTIV](https://www.emotiv.com/) EPOC+ . It has 14 saline based electrodes (each electrode represents a channel) and the choice of 128Hz or 256Hz sampling frequency. It’s also wireless, which provides an additional level of flexibility.

In order to record brain signals you'll have to download and install [CyKIT](https://github.com/CymatiCorp/CyKit) library, written in Python. Following the guide on CyKit page you'll learn how to stream EEG data into the OpenVibe platform, which is used for development of BCI applications. I've used it only to record brain data. Then I used machine learning techniques in Matlab to extract relevant information and to feed the data into the LDA classifier. You cannot proceed, until you're set with CyKIT and OpenVibe!!! 

For now, this project is made to work only with EPOC+ EEG cap, meaning that if you intend to use another cap or other acquisition platform than OpenVibe, then you'll have to do everything differently. Plus, every human brain is different, so there's that. The main purpose of this project is to show how the process of working with brain waves may look like.

After you've learnt how to use OpenVibe's scenarious, you can use one of those(look at the picture below) to start signal acquisition. Don't forget to specify the export location for Generic Stream Writer Box. One of the examples could be
"C:\Users\YourName\AppData\Roaming\openvibe-2.2.0\scenarios\signals\". That's where all your data goes to by default.

![ov](https://user-images.githubusercontent.com/38896324/57587361-d4483680-74d1-11e9-8e75-96c0ab5aa25c.png)

Now, it's time to collect some training data. When you're ready to start, press "Play" to run the OpenVibe scenario and then run the P300_Speller_Train\P300_Speller.m file. Type the desired word you'd like to focus on. I suggest you to start simple and try to do only single characters at first, beacuse this is not a very pleasant experience.

## Data Preprocessing
After the flashings are over, DataPreprocessing.m sript will be called automatically to process all the data you've recorded. The data is passed through BandPass filter to remove the irrelevant frequencies, like noise in our head, for example. Then we extract the relevant information and take an average across all 15 iterations for every character. Again, you don't have to run DataPreprocessing.m sript yourself, unless you want to make changes in the preprocessing step. There're plenty of other techniques to try, like: Signal Decimation and Principal Component Analysis (PCA). I've tried both of those, but unfortunately, they didn't help me to improve the overall accuracy.

Repeat the Data collection and Data Preprocessing steps as many times as you can. The more data you record, the higher chance you get to improve the Character Recognition accuracy!

This is an example of how your data may look like if you plot it. The red line represents the target P300 wave, and the blue line is a non-target wave. As you can see there's a clear distinction between those two.

![image](https://user-images.githubusercontent.com/38896324/57587828-8c2d1200-74d9-11e9-83e8-79b82e3996de.png)

# Step 2: Classification

When you've acquired enough data, it's time to train the classifier using P300_Speller_Train\Classification.m script. Separate your dataset into training set and testing set and feed those to the LDA classifier. You'll have to do it manually, bacause this process varies for every individual. After the classifier has been trained, you'll see the accuracy that you've achieved during training/testing. Of course, the testing accuracy in much more important to worry about, because it shows the ability of your classifier to recognize the data it hasn't seen before.

# Step 3: P300 Speller Online
Coming soon...
