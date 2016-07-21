# Virtual Environment Manager

cdenv is a simple virtual environment manager. In short, it calls setup and
teardown scripts for the environment, if they exist.

### Installation

#### Install script

To install, run the following line if you use curl:

```
curl https://raw.githubusercontent.com/croach/cdenv/master/install.sh | sh
```

or this line if you use wget:

```
wget -qO- https://raw.githubusercontent.com/croach/cdenv/master/install.sh | sh
```

> NOTE: The script will clone this repository (or curl the cdenv.sh file) into
~/.cdenv and add a few lines to source the file into your .zshrc, .bashrc, or
.profile file depending on which it finds first. If `cdenv` does not work for
you after you install it, make sure the source lines are in the correct file.

#### Manual install

To install cdenv, if you have git installed, just clone this repository.

```bash
git clone https://github.com/croach/cdenv.git ~/.cdenv
```

Otherwise, you'll need to create the directory, and copy the cdenv.sh file into it.

```bash
mkdir ~/.cdenv && curl -O https://raw.githubusercontent.com/croach/cdenv/master/cdenv.sh
```

To activate cdenv, you just need to source the cdenv.sh file. To do this
automatically everytime you begin a new shell session, copy the following
into your .bashrc or .zshrc file.

```bash
if [[ -f "$HOME/.cdenv/cdenv.sh" ]]; then
    source "$HOME/.cdenv/cdenv.sh"

    # Uncomment the following line if you want virtual environments
    # activated/deactivted as you cd into/out of them.
    # alias cd="_cdenv_cd"

    # Uncomment the following line if you want to try to check for a
    # virtual environment in the current directory (and activate it)
    # whenever a new shell session is created.
    # cdenv activate
fi
```

If you would like to automatically activate and deactivate virtual envrionments
as you `cd` into them and out of them, just uncomment the `alias cd="_cdenv_cd"`
line in the code above. Also, if you'd like to activate an environment when
creating a new shell session, just uncomment the `cdenv actiavate` line as well.

### Usage

A virtual environment is any directory that contains a `.activate` and/or
`.deactivate` file within it. To activate a virtual environment, simply cd
into it and call the `activate` command.

```bash
cd /path/to/virtual/env
cdenv activate
```

To deactivate an environment, simply call the 'deactivate virtual environment'
command.

```
cdenv deactivate
```

To get a list of all available commands along with a simple explanation of
what each one does, call the 'help' command or just call `cdenv` without a
command.

```
cdenv help
```

In addition to altering the PATH variable, cdenv also supports setup and
teardown functionality as well. if a `.activate` file is found in the directory,
it will source it when the virtual environment is activated. Likewise, if a
`.deactivate` file is found, it will source it upon deactivation. These files
allow you to do extra setup/teardown to your environment as needed.
