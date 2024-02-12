# Navigation on the app

The medias are gathered according yo their type : either *Movies*, *Series* or *Books* which can be accessed on the top rail of the app.

You can acces the different windows of the app (*Medias*, *Favorites* or *About*) in the lower rail

# How it works

We decided to use a JSON file to list and access all the different medias possible. We are hence parsing the data from the `media.JSON` file into a map for the different medias we selected.

We have seperated each part of the projet in order to work more easily on each task. We thus have a `Media` Class, a `Library` Class etc.

For the differenciation between the types of media we have associated each page with a number so that it is easier for the navigation on the website.