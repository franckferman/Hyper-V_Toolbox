# TODO.MD

## Needs & Todo

- [ ] Add a "download links" function.

At the moment, the resource management function (Resource_Management) calls a function "HPV-Download_Base" which takes as parameters several arguments including one called "isoSrc". And the resource management function fills the direct download link as an argument to this parameter. The machine creation functions (HPV-New_VM...) also work more or less on this principle. It is not dramatic but it is not optimized. Let me explain, if the download link has to be changed one day, it will have to be changed in many different places in the code. This is not dramatic because most of the inteligent text editors are able to identify and change the links easily, however, for simplicity and optimization it would be useful to create a new function named for example "download links", to be able to centralize the list of links and call them easily afterwards.

With this addition, instead of having to change the download link everywhere in the code, it will be enough to update the corresponding download link variable.

- [-] Improvement of the code logic.