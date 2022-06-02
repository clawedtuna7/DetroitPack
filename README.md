# DetroitPack
Deindustrialization and its effects in the City of Detroit

Detroit, a city once synonymous with the car manufacturing industry and the great Henry Ford, is now a place most known for the hardhsips and trouble created as a result of a quickly declining economy in the late 20th century. From its success as a manufacturing-heavy economy to the declaration of bankruptcy in the year 2013, Detroit is often seen as *the* city to have had experienced some of the worst effects of the deindustrialization period, and, as a result, has continued to struggle in rebuilding its economy and stature in this new age.

This story is not unique, many cities, towns, and metro areas throughout the United States have experienced some kind of economic turbulance within recent years as the result of the decline in manufacturing based jobs/economies - especially in the region we now know as the Rust Belt. Enrico Moretti, author of the *"The New Geography of Jobs"*, mentions that the manufacturing industry - once the nation's primary economic driver - had "lost an average of 372,000 manufacturing related jobs every year" since the mid 1980s. Many cities, like that of Chicago, learned to diversify and adapt their economies, while others were left struggled to so, Detroit being a primary example.

Detroit, as well as manny other cities and metropolitan areas in the Midwest, increasingly  grew in trouble throughout this period as factories and corporations either struggled as a resultof growing competition, introduced and encouraged automation, or physically moved their businesses in search of cheaper labor.

Today, the city of Detroit is different from what it was 10 years ago, and even more different from what it was 40 years ago. The change of Detroit, economically and demographically, is what this package explores and models. Basic in its initial data sets, this package aims to serve as the basis for a greater analysis, ~~inviting~~ ecouraging those interested to integrate more complex data that would help illustrate the phenomenon of desindustrialization the City of Detroit experienced in the time period between 1980 and 2010. 

The DetroitPack contains:
      
1. MI_1980 - 1980 Demographic and Poverty realted data for the state of Michigan
      
2. MI_2010 - 2010 Demographic and Poverty(+) related data for the state of Michigan
      
3. Detroit3593 - City of Detroit Boundaries
      
4. Dtracts80 - 1980 Census tracts that intersect with City of Detroit Boundaries
      
5. Dtracts10 - 2010 Census tracts that intersect with City of Detroit Boundaries


## Example Analysis

Looking at three variables available in both of the MI_xxxx sets, this analysis will aim to model the changes in each of these 
selected variables accross the 30 year gap between data sets. 

```{r}
tm_shape(Det1980) + tm_polygons(col = "totpop1980Pr", style = "jenks") + tm_shape(Detroit3593) + tm_borders(col = "black", lwd = 2)

tm_shape(Det1980) + tm_polygons(col = "Poverty80Pr", style = "jenks", palette = "Blues") + tm_shape(Detroit3593) + tm_borders(col = "black", lwd = 2)

tm_shape(Det1980) + tm_polygons(col = "aframPr80", style = "jenks", palette = "Greens") + tm_shape(Detroit3593) + tm_borders(col = "black", lwd = 2)
```

<img width="574" alt="1980" src="https://user-images.githubusercontent.com/104933882/171603067-d091af2a-676b-4f6f-9ad6-b38c6d292ad0.png">

Looking at the population percentage, one can see that the center of the city is less populated, compared to the rest of the tracts within and outside the city. Despite this area being the less populated region of the city, this is the area that has a higher proportion of those living under poverty - especially the area just west of the center of the city. Comparing the African American population proportion map with the maps above, one can see that the African American population makes up the majority in a lot of the tracts within the city. Because of this, this share of the population of Detroit experiences a range of poverty values, with the center and western part of the population being the regions which experience living under impoverished conditions

```{r}
tm_shape(Det2010) + tm_polygons(col = "totpop2010Pr", style = "jenks") + tm_shape(Detroit3593) + tm_borders(col = "black", lwd = 2)

tm_shape(Det2010) + tm_polygons(col = "Poverty", style = "jenks", palette = "Blues") + tm_shape(Detroit3593) + tm_borders(col = "black", lwd = 2)

tm_shape(Det2010) + tm_polygons(col = "aframPr10", style = "jenks", palette = "Greens") + tm_shape(Detroit3593) + tm_borders(col = "black", lwd = 2)
```

<img width="602" alt="2010" src="https://user-images.githubusercontent.com/104933882/171603097-c7f01a03-bd15-45f1-b0c3-b3a30bbe9d61.png">

For the set of maps in 2010, one can clearly see that these are all different from the first set of maps. The population proportion map shows that tracts within the Detroit borders, compared to those outside of the borders, have a smaller proportion of the population - with the center of the city, again, housing the least people. The poverty proportion map, unlike the one above, seems to be much more dispersed and, seemingly, more random. One could infer that this could be a result of the tumultuous economic period the city was going through after the 2008 recession, which would eventually lead to the declaration of bankruptcy in 2013. The share of African Americans in the city between 1980 and 2010 exploded. This is mostly true for the tracts inside the city boundary, but no so much for those tracts outside the city - especially those on the northern end and the unincorporated region at the center of the city. 

             
