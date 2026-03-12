# My dotfiles
This repository contains my dotfiles. A thorough description of the main features can be found in [DESC.md](https://github.com/ndrscalia/dotfiles/blob/main/DESC.md) and in other docs that are there referenced.


The objective of these dotfiles is to make your terminal an actual productive space that you can live in, while at same time avoiding clutter and too much maintenance overhead. You will have to do minor fixes from time to time when you do update something.

## Requirements
Install `git` and `stow`.
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
It is a good idea to create a global stow-ignore file if it does not exists in your home directory.
This is a template with all the default expressions - plus `.DS_Store` if you are on MacOS:
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

Now you can use GNU stow to create symlinks with the following command:
```
stow .
```

Use version control and branching to avoid headaches. In this way, you can work on this repo and it will sync with all your dotfiles and config.

## How to create such a repo from scratch
I used [this tutorial](https://www.youtube.com/watch?v=y6XCebnB9gs) to organize this workflow.
