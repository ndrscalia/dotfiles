# My dotfiles
This repository contains my dotfiles.

## Requiremnts
Install `git` and `stow`
```
brew install git
brew install stow
```
## Installation
Clone the repo in your home directory and navigate to the repo's root.
```
git clone https://github.com/ndrscalia/dotfiles.git
cd dotfiles
```
Now you can use GNU stow to create symlinks with the following command:
```stow .
```
## How create such a repo from scratch
I used [this tutorial] (https://www.youtube.com/watch?v=y6XCebnB9gs). The workflow is the following:
```
# dotfile/
cp ~/.dotfile . # use cp -R if you're copying a directory
mv ~/.dotfile ~/.dotfile.bak
stow .
```
Then you can do the usual git stuff to add version control.
## stow-ignore
In the event you have to do everything from scratch, it is a good idea to create a global stow-ignore file if it does not exists in your home directory.
```
touch .stow-global-ignore
```
This is a template with all the default expressions plus `.DS_Store`:
```
RCS
.+,

CVS
\.\#.+
\.cvsignore

\.svn
_darcs
\.hg

\.git
\.gitignore
\.gitmodules

.+~
\#.*\#

^/README.*
^/LICENSE.*
^/COPYING

.DS_Store

```
