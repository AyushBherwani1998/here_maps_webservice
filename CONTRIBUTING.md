# Contributing to the `here_maps_webservice`

### What you will need
- A Linux, Mac OS X, or Windows machine 
- [git](https://git-scm.com/)
- [Set up Dart SDK](https://www.dartlang.org/tools/sdk)
- [Set up Flutter SDK](https://flutter.dev/docs/get-started/install)

### Setting up your development environment
- Fork https://github.com/AyushBherwani1998/here_maps_webservice.git into your own GitHub account.
- Clone your forked repo on your local development machine:
  ```sh
    git clone git@github.com:<your_name_here>/here_maps_webservice.git
  ``` 
- Change into the here_maps_webservice directory: 
  ```sh
     cd google_maps_webservice
  ```
- Add an upstream to the original repo, so that fetch from the master repository and not your clone:
  ```sh
      git remote add upstream git@github.com:AyushBherwani1998/here_maps_webservice.git
  ```     

### Running the example project     

- Change into the example directory: 
  ```sh
   cd example 
   flutter run
   ```

  
### Contribute
We really appreciate contributions via GitHub pull requests. To contribute take the following steps:

- Make sure you are up to date with the latest code on the master:
  ```sh
     git fetch upstream
     git checkout upstream/master -b <name_of_your_branch>
  ```     
- Apply your changes
- Verify your changes
- Commit your changes:
   ```sh
     git commit -m "<your informative commit message>"
   ```
 - Push changes to your fork:
   ```sh
     git push origin <name_of_your_branch>
   ```

### Send us your pull request:

Go to https://github.com/AyushBherwani1998/here_maps_webservice and click the "Compare & pull request" button.
