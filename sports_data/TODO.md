
====

### Statsbomb (Events + 360)

Penn et al (2025) provide a way (package) of turning a Statsbomb event + 360 match into tracking data by predicting player x,y coordinates between 360 frames based on physical constraints. 
- Read this an makes sense. Author highlights some limitations around off-camera players and breaks. Its not intuatively clear whether the former here would impact the goal to focus on through balls and line breaking passes. Long range version of these passes may be innaccurate due to out of frame defenders but this could be circumnavigated looking at shorter range passes (`pass_length` < X). This probably something that can only be worked out by sense checking scenarios which will depend on the task chosen for the project. Having the functions and code set up to view events data but also tracking data snippets would be useful.  

`https://github.com/mpenn114/Football-Tracking-Interpolation`

> Penn, M.J., Donnelly, C.A. and Bhatt, S., 2025. Continuous football player tracking from discrete broadcast data. Royal Society Open Science, 12(10).

- **"Football Analytics Based on Player Tracking Data Using Interpolation Techniques for the Prediction of Missing Coordinates" (Kontos & Karlis, 2024).** This paper tackles the exact same "censoring effect" of broadcast TV (where cameras pan away and leave players off-screen). Probably not relevant for me but helped to understand the underlying problem that Penn is solving as their goal isn't to solve Statsbomb 360 data, this was just a useful application to large issue of interpolocation of off-screen players from broadcasting derived data. 

[Use Statsbombpy with Python by Hudl](https://support.hudl.com/s/article/use-statsbombpy-python?language=en_US&topic=Statsbomb_Python_Tools#:~:text=Expand%20Tree%20Branch%20Analyze%20Shot,Branch%20Create%20League%20Pass%20Clusters)

[statsbomb/statsbombpy](https://github.com/statsbomb/statsbombpy)





====

[Metrica Sports](https://github.com/metrica-sports/sample-data)

3 tracking games 

====

[SkillCorner](https://github.com/SkillCorner/opendata)

10 tracking matches with events data

====

##### A public data set of spatio-temporal match events in soccer competitions (Pappalardo et al. 2019)

A derivation of WyScout event data. Purpose of the paper was to tackle reproducibility and standardization in football analytics. 

> Pappalardo, L., Cintia, P., Rossi, A., Massucco, E., Ferragina, P., Pedreschi, D. and Giannotti, F., 2019. A public data set of spatio-temporal match events in soccer competitions. Scientific data, 6(1), p.236.