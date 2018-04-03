## Data retrieval and storage
When the app is launched, base film data is fetched from the Star Wars API. Once the data has been retrieved, a search request is fired off to the OMDB API which matches each film to an IMDB poster image and rating. These two sets of data are amalgamated and stored locally (Core Data).

Character information for each film is fetched seperately (but still during the main fetch task), since the API provides URLs as a means of linking related film data. Characters are stored as a many-to-one relationship with a Film.

The loading and storage of data happens during a 'loading' screen when the app is launched. All subsequent data requests throughout the app are from the local Core Data store.

## Possible Improvements
- Change the Character and Film relationship to many-to-many via a linker object ("table") as to not store duplicate character information.
- Introduce image caching as to avoid uneccesary image retrievals over the network
- Have the splash screen detect that local data is present, and then move on to the home view without waiting to fetch fresh data. This will give a better user experience as the user will almost instantaneously be presented with data.
