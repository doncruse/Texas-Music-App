# Texas Music App

Built at the Hacks-Hackers Austin "hackathon" on October 16, 2010.

## Information sources

The band information was scraped from the website of the Texas Music Office, which is a division of state government that promotes the Texas music industry.

## What the app does

At this point, the App filters the band information by city, by genre, or both.  It also provides a simple search feature that will match partial band names.

## Data limitations

The data is not particularly clean &mdash; there are misspelled cities, duplicative genre tags, and a few duplicate band names.  A human being will have to clean the data set somewhat.

Also, the only unit of geography in the database is the city name, which is difficult to work with. An improved version would map those city names to regions of the state, or at least to geocode coordinates to permit a "near me" search.

The sheer number of genres also makes further analysis difficult.  The bands were apparently permitted to name their own genres, and they came up with well over 200 of them.  In only a few cases (such as "Rap/Hip-Hop") does it look like the Texas Music Office tried to standardize bands on a common label for their genre.

## Code limitations & next steps

One big problem is that there are too many empty hits if a user tries "city" and "genre" searching.  That's because so many Texas cities are small, and there are such a wide variety of genre names.  A solution would be to tie the two together so that a user who has chosen a city name is then presented with a list of genres present in that city (whether by a tag cloud or by another drop-down menu).

The opposite problem can arise if a user just tries a "city" *without* a "genre."  In that case, the sheer volume of results can clog up the system.  The easiest solution would be adding pagination to the search results.  (This solution would go hand-in-hand with showing a tag cloud of the genres available in that city so that a user could easily filter.)

I like the idea of geocoding the cities to have a "near me" search.  This could have practical value.

I also like the idea of selecting a genre and seeing a map of where in the state bands with that genre are concentrated.
