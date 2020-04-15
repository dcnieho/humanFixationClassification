This repository contains the coder settings and event-based agreement
score algorithms used and developed for the article Hooge, I.T.C.,
Niehorster, D.C., Nyström, M., Andersson, R. & Hessels, R.S. (2017). Is
human classification by experienced untrained observers a gold standard
in fixation detection?  https://doi.org/10.3758/s13428-017-0955-x

When using the algorithms or coder settings in this repository in your
work, please cite the Hooge et al. paper.

This repository also contains the eye-movement data used as stimuli in
the Hooge et al. paper. When using the infant data files, please cite
Hessels, R.S., Hooge, I.T.C., & Kemner, C. (2016). An in-depth look at
saccadic search in infancy. Journal of Vision, 16(8), 10.
http://doi.org/10.1167/16.8.10. When using the adult data files, please
cite Hooge, I.T.C., Niehorster, D.C., Nyström, M., Andersson, R. &
Hessels, R.S. (2017). Is human classification by experienced untrained
observers a gold standard in fixation detection?
https://doi.org/10.3758/s13428-017-0955-x

For more information or questions, e-mail: i.hooge@uu.nl /
dcnieho@gmail.com. The latest version of this repository is available
from www.github.com/dcnieho/humanFixationClassification

The algorithms in this repository are licensed under the Creative
Commons Attribution 4.0 (CC BY 4.0) license. The coder settings and
eye-movement data used as stimuli are licensed under the Creative
Commons Attribution-NonCommercial-ShareAlike 4.0 (CC NC-BY-SA 4.0)
license.

Contents:
- To explore the event based F1 and relative timing offset and difference
  scores, run the files F1_example.m and RTO_RTD_example.m, respectively.
- To reproduce the F1, RTO and RTD scores from Hooge et al. (2017),
  run doF1_RTO_RTD_forAll.m
- To graphically explore the settings coders made, run
  coderSettingPlotter.m
- the coder settings are found in data/coderSettings
- the eye-movement data that were coded are found in data/ETdata. Data
  were recorded on a 1920x1080 screen that measured 50.9 x 28.6 cm. The
  viewing distance was approximately 65 cm.

Tested on MATLAB R2012a, R2017a & R2019b

## Version History
N.B.: complete details of changes made is available on [github](https://github.com/dcnieho/humanFixationClassification)
### Version 1.0 - changes from 0.9.2
- made F1 score calculation scripts faster and more robust
- ensured correct fixation durations appear in anonymized coding setting files
### Version 1.1 - changes from 1.0
- corrected time shifts found in the onset and offsets times of the classified fixations for 14 out of the 70 stimulus files 
- updated y-axis labels in coderSettingPlotter.m: deg -> pix
- updated coderSettingPlotter.m to step through data trial by trial instead of per coder per trial
- updated coderSettingPlotter.m to enable viewing a specific coder's settings by clicking on that coder's settings in the scarfplot
