# About the sample data set

This lesson is centered around reading and performing simple processing on
a sample experiment data set.  This document describes the data format and
variables as well as the experiment that generated the data set.

## Variable Dictionary

The data set is provided in a CSV file with five columns representing the
following variables.

## `Subject`

**Type** Identifier

**Description** Arbitrarily assigned unique identifier for each subject

**Values** Positive consecutive integers starting at 1

## `OSPAN_Group`

**Type** Group/Between-subjects

**Description** High vs. Low working memory capacity based on OSPAN score

**Values**
* `High` = at or above median OSPAN score of 55
* `Low` = below median OSPAN score of 55

## `OSPAN_Score`

**Type** Repeated/Within-subjects

**Description** Operation span score (higher the score, higher the working memory capacity)

**Values** Positive Integers (number of words recalled)

## `Distracter_easy`

**Type** Repeated/Within-subjects

**Description** Amplitude (microvolts) of electrical brain signal to distracting sounds in EASY condition

**Values** Decimal numbers (microvolts)

## `Distracter_hard`

**Type** Repeated/Within-subjects

**Description** Amplitude (microvolts) of electrical brain signal to distracting sounds in HARD condition

**Values** Decimal numbers (microvolts)

## Experiment Summary

### Premise
There is behavioral evidence that individuals with better short term (working) memory are better able to focus attention and withstand distraction.

We wanted to find out if this behavioral difference is due to differences in how our brains process distracting information.

### Tasks
#### OSPAN task
* Measured all subjects' operation span (index of working memory capacity). Operation Span test presents alternating math problems with letters, and subjects are to recall letters in correct order when prompted
* A median OSPAN score of 55 was used to divide subjects into "High" and "Low" working memory capacity groups

#### Attention task
* All subjects completed an auditory attention task in which they listened for a target tone that was played amid other nontarget tones and distracting sounds.
* They each completed this task under two conditions: Easy vs. Hard
* In the easy condition, target and nontarget tone frequencies were far enough apart to be easily distinguishable (see table below)


```
                |     Easy	          Hard
    ============|=============================
    Target      |       1000Hz          1000Hz
    Nontarget   |        500Hz           950Hz
    Distracter  |  White Noise	   White Noise
```

### EEG/brain activity
We used EEG to measure electrical brain activity (amplitude in microvolts) associated with processing each type of sound (target, nontarget, distracter).

The dataset here shows amplitude (in microvolts) of brain activity associated with processing the distracter sound.

This neural activity occurred ~100ms after the presentation of the distracting sound, and was picked up by electrode placed on the scalp at the middle-top of forehead (index of frontal lobe activity).

In general, this brain response is an index of distraction; the larger the amplitude, the more the person was distracted by the white noise.

### Statistical Results
**Main effect of task condition**

larger amplitudes under easy condition &rarr; suggests more distraction when task is easy (i.e. does not fully engage attention)

**Main effect of subj group**

larger amplitudes for low working memory group &rarr; suggest low working memory group more easily distracted/less focused

## Reference
Yurgil K.A. & Golob E.J. (2013).  **Cortical potentials in an auditory oddball task reflect individual differences in working memory capacity.**  Psychophysiology,  50(12), 1263-1274.  PMID: 24016201
