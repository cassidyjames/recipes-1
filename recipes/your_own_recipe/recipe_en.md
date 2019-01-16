#Add own recipe

Do you want your own recipe to show up in the app?

###You can do one of the following things:

* Just create a PR [here](https://github.com/bartzaalberg/recipes)
* Or send me an email at bartzaalberg@gmail.com

###Steps for PR:

1. Fork the repository.
2. Create a folder with the name of your recipe under 'recipes' in the repository. (example '/recipes/very_nice_meat_recipe')
3. Create the recipe file 'recipe_<the language you are creating in>.md' in the folder. (example 'recipe_en.md' for english)
4. Add your recipe to the '/data/recipes.json' as followed

```
{
    "id": "very_nice_meat_recipe",
    "title": "Very nice meat recipe",
    "thumbnail": "https://www.someimagelink.nl",
    "author": "you",
    "languages": ["en"]
},
```
5. Thats it! You can commit and create the pull request.

#### Image

You can also add an image in the folder and link to it from the markdown and json file.