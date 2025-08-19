# emotion_cognition_network
Code for identifying brain networks linked to cognition (reaction time, working memory) and emotion (neuroticism, anhedonia) in the UK Biobank (UKBB), and testing their associations with stress, anxiety, and depression measures in the AURORA study.


By applying group-ICA to resting state fMRI data, we first identified 53 brain regions for each participant and grouped them into seven resting-state networks: the subcortical (SC), auditory (AUD), sensorimotor (SM), visual sensory (VIS), cognitive control (CC), default mode (DM), and cerebellar (CB) networks. After calculating functional connectivity among these 53 networks, we obtained 1,378 measures per participant (Fig. 1c). We then developed general linear models (GLMs) to examine relationships between two cognitive measures, choice reaction time  and numeric memory, while including age, age2, sex, the age × sex interaction, and the site of data collection as covariates (**Fig. 1d**).  
Figure 1 is shown here

<img width="468" height="555" alt="image" src="https://github.com/user-attachments/assets/e103cd3a-d28a-4c97-9961-e75acf77718e" />

**Brain networks linked to cognitive function in the healthy UKBB sample**

We then developed general linear models (GLMs) to examine relationships between two cognitive measures, choice reaction time  and numeric memory and 1,378 FNC measrues while including age, age2, sex, the age × sex interaction, and the site of data collection as covariates  

**Fig. 2a** displays 28 brain connections that remained significant after FDR correction in the model linking reaction time to functional connectivity in UKBB (**Supplementary Data 1**). In this figure, red lines indicate connections associated with longer reaction times, suggesting reduced cognitive function, while blue lines indicate connections associated with shorter reaction times, indicative of enhanced cognitive function. Additionally, the top five connectivity measures showing the strongest association with reaction time are displayed, along with the percentage contribution of each network in the model. Notably, the findings indicate the CC network is the most influential, accounting for 46% of all connections related to reaction time. 

**Fig. 2b** shows brain networks associated with numeric memory scores after FDR correction. From 1,378 connectivity measures, 239 were identified as relevant to numeric memory (**Supplementary Data 2**). Red lines indicate connections linked to poorer performance, while blue lines reflect associations with better numeric memory, suggesting enhanced cognitive function.  Notably, approximately 43% of these connections involved the CC, either within the CC network or between the CC network and other networks. 


**Brain networks linked to emotion dysregulation in the healthy UKBB sample**

We developed multiple GLMs to investigate relationships between 1,378 FNC measures and our chosen indices of emotion dysregulation, focusing on neuroticism and anhedonia. Our model again included age, age2, sex, the age × sex interaction, and the site of data collection as covariates. **Fig. 2c** illustrates 34 functional connectivity links with neuroticism that remained significant after FDR correction (**Supplementary Data 3**). Red lines are connections linked to higher neuroticism, while blue lines are associated with lower neuroticism.

**Fig. 2d** illustrates all 262 (out of 1,378) connectivity links with anhedonia that remained significant after applying FDR correction (**Supplementary Data 4**). Red lines indicate connections linked to the presence of anhedonia, while blue lines are connections linked to its absence. As shown, the CC accounted for 34% of the connections, while the VIS, SM, and DM networks contributed 18%, 16%, and 14%, respectively. 

<img width="595" height="354" alt="image" src="https://github.com/user-attachments/assets/aa0e7654-c1db-495d-a296-404e49f6c7b9" />

**Networks linked to cognitive function in healthy adults are associated with symptom severity in trauma-exposed individuals**

We used a GLM to examine associations between the brain networks linked with cognitive function in UKBB and symptom severity related to stress, anxiety, and depression assessed two weeks after trauma exposure in individuals from the AURORA study. The model included age, sex, age2, age x sex interaction, income, years of education, site, and type of trauma as covariates. **Fig. 3a** illustrates the reaction time networks alongside measures of stress, anxiety, and depression (**Supplementary Data 5, 6, and 7**). Among the 28 connectivity measures related to reaction time in UKBB, only connectivity between left posterior cingulate cortex and left middle frontal gyrus was significantly associated with stress measures (i.e., PCL-5) in AURORA after FDR correction (β = 23.73, SE = 6.20, r = 0.21, FDR p = 0.0047). No significant associations were found between these brain networks and measures of anxiety or depression after FDR correction.

Fig. 3b depicts the relationship between the numeric memory network identified in UKBB and symptom severity in AURORA (Supplementary Data 8, 9, and 10). Our results indicate that connectivity between left posterior cingulate cortex and left anterior cingulate cortex was significantly associated with  stress measured with PCL-5 (β = 24.03, SE = 5.54, r =0.20, FDR p = 3e-4), anxiety measured with PROMIS anxiety  (β = 5.00, SE = 1.37, r = 0.20, FDR p = 0.030), and depression measured with PROMIS depression (β = 11.81, SE = 3.08, r = 0.21, FDR p = 0.038) in AURORA participants. Additionally, connectivity between right inferior parietal lobe and right inferior frontal gyrus was associated with stress (β = 23.18, SE = 6.33, r = 0.20, FDR p =0.037), while precuneus and left inferior occipital gyrus connectivity and precuneus and right middle occipital gyrus connectivity were significantly associated with anxiety (precuneus/inferior occipital gyrus: β = -5.21, SE = 1.44, r = -0.20, FDR p = 0.030; precuneus/right middle occipital gyrus: β = -4.92, SE = 1.42, r = -0.19, FDR p = 0.039). Furthermore, connectivity between left inferior parietal lobule and superior parietal lobule was significantly associated with anxiety measures (β = 6.49, SE = 1.69, r = 0.21, FDR p = 0.030).
<img width="612" height="329" alt="image" src="https://github.com/user-attachments/assets/a5786728-7d5b-4fdf-8fe8-fdb63d217d76" />



