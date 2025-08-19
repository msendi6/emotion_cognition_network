# emotion_cognition_network
Code for identifying brain networks linked to cognition (reaction time, working memory) and emotion (neuroticism, anhedonia) in the UK Biobank (UKBB), and testing their associations with stress, anxiety, and depression measures in the AURORA study.


By applying group-ICA to resting state fMRI data, we first identified 53 brain regions for each participant and grouped them into seven resting-state networks: the subcortical (SC), auditory (AUD), sensorimotor (SM), visual sensory (VIS), cognitive control (CC), default mode (DM), and cerebellar (CB) networks. After calculating functional connectivity among these 53 networks, we obtained 1,378 measures per participant (Fig. 1c). We then developed general linear models (GLMs) to examine relationships between two cognitive measures, choice reaction time  and numeric memory, while including age, age2, sex, the age × sex interaction, and the site of data collection as covariates (Fig. 1d).  
Figure 1 is shown here

<img width="468" height="555" alt="image" src="https://github.com/user-attachments/assets/e103cd3a-d28a-4c97-9961-e75acf77718e" />

We then developed general linear models (GLMs) to examine relationships between two cognitive measures, choice reaction time  and numeric memory and 1,378 FNC measrues while including age, age2, sex, the age × sex interaction, and the site of data collection as covariates   
