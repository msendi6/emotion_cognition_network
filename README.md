# emotion_cognition_network
Code for identifying brain networks linked to cognition (reaction time, working memory) and emotion (neuroticism, anhedonia) in the UK Biobank (UKBB), and testing their associations with stress, anxiety, and depression measures in the AURORA study.


By applying group-ICA to resting state fMRI data, we first identified 53 brain regions for each participant and grouped them into seven resting-state networks: the subcortical (SC), auditory (AUD), sensorimotor (SM), visual sensory (VIS), cognitive control (CC), default mode (DM), and cerebellar (CB) networks. After calculating functional connectivity among these 53 networks, we obtained 1,378 measures per participant (Fig. 1c). We then developed general linear models (GLMs) to examine relationships between two cognitive measures, choice reaction time  and numeric memory, while including age, age2, sex, the age × sex interaction, and the site of data collection as covariates (**Fig. 1d**).  
Figure 1 is shown here

<img width="468" height="555" alt="image" src="https://github.com/user-attachments/assets/e103cd3a-d28a-4c97-9961-e75acf77718e" />

We then developed general linear models (GLMs) to examine relationships between two cognitive measures, choice reaction time  and numeric memory and 1,378 FNC measrues while including age, age2, sex, the age × sex interaction, and the site of data collection as covariates   

**Fig. 2a** displays 28 brain connections that remained significant after FDR correction in the model linking reaction time to functional connectivity in UKBB (**Supplementary Data 1**). In this figure, red lines indicate connections associated with longer reaction times, suggesting reduced cognitive function, while blue lines indicate connections associated with shorter reaction times, indicative of enhanced cognitive function. Additionally, the top five connectivity measures showing the strongest association with reaction time are displayed, along with the percentage contribution of each network in the model. Notably, the findings indicate the CC network is the most influential, accounting for 46% of all connections related to reaction time. 

**Fig. 2b** shows brain networks associated with numeric memory scores after FDR correction. From 1,378 connectivity measures, 239 were identified as relevant to numeric memory (**Supplementary Data 2**). Red lines indicate connections linked to poorer performance, while blue lines reflect associations with better numeric memory, suggesting enhanced cognitive function.  Notably, approximately 43% of these connections involved the CC, either within the CC network or between the CC network and other networks. 

We developed multiple GLMs to investigate relationships between 1,378 FNC measures and our chosen indices of emotion dysregulation, focusing on neuroticism and anhedonia. Our model again included age, age2, sex, the age × sex interaction, and the site of data collection as covariates. **Fig. 2c** illustrates 34 functional connectivity links with neuroticism that remained significant after FDR correction (**Supplementary Data 3**). Red lines are connections linked to higher neuroticism, while blue lines are associated with lower neuroticism.

**Fig. 2d** illustrates all 262 (out of 1,378) connectivity links with anhedonia that remained significant after applying FDR correction (**Supplementary Data 4**). Red lines indicate connections linked to the presence of anhedonia, while blue lines are connections linked to its absence. As shown, the CC accounted for 34% of the connections, while the VIS, SM, and DM networks contributed 18%, 16%, and 14%, respectively. 

<img width="595" height="354" alt="image" src="https://github.com/user-attachments/assets/aa0e7654-c1db-495d-a296-404e49f6c7b9" />

