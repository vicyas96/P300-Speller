# P300-Speller
  Hello Everyone. Here I would like to show a project, that describes the process of development a Brain Computer Interface (BCI) that can help people interact with surroundings, using only their thoughts with the application called P300 Speller.

  P300 Speller is an application that allows people spell words and display them on the screen by using only the power of thoughts. It uses visual stimulation, meaning that when we focus on specific visual stimuli, our brain produces specific patterns. Those patterns appear in our brain approximately after 300ms after presentation. So, this is basically a delayed response in our brain. This phenomenon is called P300. The application itself represents a matrix that consists of letters and numbers. Rows and columns are randomly highlighted with the interval of 100ms each. The subject is nicely asked to focus his attention on just one letter, and once the desired letter is highlighted the signal goes through the occipital lobe of your brain. EEG cap captures that activity and sends it to computer. Then classification algorithm is used to choose the correct result. Once it’s done, the letter subject was focusing on appears on the screen. And so the process is repeated, letter by letter, until the whole word is formed. The reason why rows and columns are highlighted randomly and not consecutively is that the best way to initiate a P300 wave in your brain is to excite it, meaning that if your brain doesn’t know which row or column is flashed next, then it won’t get used to it. 

  This is how the P300 Speller looks like:

  <a href="https://imgflip.com/gif/30rktl"><img src="https://i.imgflip.com/30rktl.gif" title="made at imgflip.com"/></a>

While designing the application I've noticed that most of the research papers that I’ve read had  the same standard: keep rows and columns flashed for 100ms, and the gap of 75ms between them. I’ve used 15 iterations for every row and column (12), which would give me 180 flashing for a single character. After the user clicks the start button, the target letter that I need to focus on gets highlighted in blue for 4 seconds before everything starts flashing. This feature is used to keep the user from forgetting the next letter he/she has to focus on. After that the flashings begin. Every time your target letter is flashed it creates a P300 wave in your brain. Everything else that is being flashed is considered to be a non-target wave. 

# Step1: Data Collection
First of all we need to record the brain signals to train computer to be able to distnguish between target P300 and non-target brain waves. There are multiples ways to do that. The one I’ve used is called Electroencephalogram or EEG for short. It is an activity of acquiring brain waves from a scalp. The way it works, is that the subject places the EEG cap on the scalp, and the electrodes detect the electrical activity in the brain.

EEG cap that I’ve used through all this time is called [EMOTIV](https://www.emotiv.com/) EPOC+ . It has 14 saline based electrodes (each electrode represents a channel) and the choice of 128Hz or 256Hz sampling frequency. It’s also wireless, which provides an additional level of flexibility.

In order to record brain signals you'll have to download and install [CyKIT](https://github.com/CymatiCorp/CyKit) library, written in Python. Following this guilde you'll learn how to stream EEG data into the OpenVibe platform, which is used for development of BCI applications. I've used it only to record brain data. Then I used machine learning techniques in Matlab to extract relevant information and to feed the data into the LDA classifier. You cannot proceed, until you're set with CyKIT and OpenVibe!!!


