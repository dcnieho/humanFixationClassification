This repository contains the coder settings and event-based agreement
score algorithms used and developed for the article
Hooge, I.T.C., Niehorster, D.C., Nyström, M., Andersson, R. & Hessels,
R.S. (submitted). Is human classification by experienced untrained
observers a gold standard in fixation detection?
When using the algorithms or coder settings in this repository in your
work, please cite the Hooge et al. paper.

This repository also contains the eye-movement data used as stimuli in
the Hooge et al. paper. When using the infant data files, please cite
Hessels, R.S., Hooge, I.T.C., & Kemner, C. (2016). An in-depth look at
saccadic search in infancy. Journal of Vision, 16(8), 10.
http://doi.org/10.1167/16.8.10. When using the adult data files, please
cite Hooge, I.T.C., Niehorster, D.C., Nyström, M., Andersson, R. &
Hessels, R.S. (submitted). Is human classification a gold standard in
fixation detection?

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
- To reproduce the F1, RTO and RTD scores from Hooge et al. (submitted),
  run doF1_RTO_RTD_forAll.m
- To graphically explore the settings coders made, run
  coderSettingPlotter.m
- the coder settings are found in data/coderSettings
- the eye-movement data that were coded are found in data/ETdata

Tested on MATLAB R2012a & R2017a
