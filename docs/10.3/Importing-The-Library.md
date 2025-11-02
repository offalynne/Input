# Importing The Library

?> Input is intended for use with Git, or an equivalent source control system. You should set up source control before importing Input.

You can find the latest version of Input [here](https://github.com/offalynne/Input/releases). Make sure that you're using a version of GameMaker that Input supports, and then download the `.yymps` from that page and import into your GameMaker project. You'll see a folder called `Input` appear in your asset browser, and a few external data files will also be created in your Included Files.

If you look inside the Input folder you'll see a lot of subfolders. These subfolders contain functions that comprise the API - the interface that you'll need to execute Input code in your game. The `(System)` folder holds code that Input requires to operate and has to be there but otherwise you can forget it exists. You'll also see a folder called `Config` - inside this folder are a series of scripts that control how Input functions. **You should edit these scripts to tailor Input to your needs.**

Finally, Input is built with the presumption that legacy runtime behaviours have been switched off. These legacy behaviours will sometimes get turned on when updating an old project to a new version of GameMaker. You can see what legacy options have been turned on by going to the Game Options for your project and then unfolding the "Deprecated Behaviours" subheading. The "Enable Copy On Write Behaviour For Arrays" option will definitely need to be disabled (unticked). Other legacy behaviours may have an impact too and likely should be unticked for Input to work properly.

&nbsp;

## Updating Input {docsify-ignore}

From time to time we’ll need to release updates to Input, either to add new features or to address bugs.

1. Create a backup of your configuration scripts, preferably via source control
2. Delete the Input folder from the asset browser
3. Import the Input .yymps from the GitHub releases page
4. Restore your configuration scripts. Some macros may have changed between versions so take special care when restoring values
