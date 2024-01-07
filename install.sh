#!/bin/bash

# Install - Symlink config files
# https://github.com/paulirish/dotfiles/blob/master/symlink-setup.sh
# https://github.com/alrra/dotfiles/blob/master/os/create_symbolic_links.sh
#
# Bash conditional statements: http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html
#

cd "$(dirname "$BASH_SOURCE")" \
    && source 'shell/utils/utils.sh'

#declare dotfilesDirectory="$HOME/Work/projects/_dotfiles"
declare dotfilesDirectory="$(pwd)"


cool_logo() {
    cat << CoolLogoBro

    ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
    ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
    ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
    ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
    ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
    ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

CoolLogoBro
}

cool_logo


check_git_local() {

    local gitconfig_local_file="$(pwd)/git/gitconfig.local"

    if [ ! -e $gitconfig_local_file ]; then
        # Prompt for name and email
        print_error "$gitconfig_local_file not found!"
        echo "Your name:"
        read git_name
        echo "Your email:"
        read git_email

        # Print to config file
        echo "[user]" > $gitconfig_local_file
        echo "  name = $git_name" >> $gitconfig_local_file
        echo "  email = $git_email" >> $gitconfig_local_file

        ask_for_confirmation "Would you like to set Sublime Text as your Git editor?"
        if answer_is_yes; then

            # Display symlink warning
            print_info " Make sure you symlink 'subl' into /usr/local/bin directory, else you will get errors\n  http://www.sublimetext.com/docs/3/osx_command_line.html\n\n  eg:\n  cd /usr/local/bin\n  ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

            # Print to config file
            echo "" >> $gitconfig_local_file
            echo "[core]" >> $gitconfig_local_file
            echo "  # Set the default editor to Sublime Text - need to alias it to work:" >> $gitconfig_local_file
            echo "  # http://www.sublimetext.com/docs/3/osx_command_line.html" >> $gitconfig_local_file
            echo "  editor = subl -n -w" >> $gitconfig_local_file

        fi

    else
        print_success "Using existing $gitconfig_local_file"
    fi

}

check_git_local


# finds all .dotfiles in this folder
#declare -a FILES_TO_SYMLINK=$(find . -type f -maxdepth 1 -name ".*" -not -name .DS_Store -not -name .git -not -name .osx | sed -e 's|//|/|' | sed -e 's|./.|.|')
#FILES_TO_SYMLINK="$FILES_TO_SYMLINK .vim bin" # add in vim and the binaries
declare -a FILES_TO_SYMLINK=(

    'shell/bash_aliases'
    'shell/bash_exports'
    'shell/bash_functions'
    'shell/bash_logout'
    'shell/bash_options'
    'shell/bash_profile'
    'shell/bash_prompt'
    'shell/bash.local'

    'shell/bashrc'
    'shell/curlrc'
    'shell/inputrc'
    'shell/screenrc'

    'git/gitattributes'
    'git/gitconfig'
    'git/gitconfig.local'
    'git/gitignore_global'

)

main() {

    local i=""
    local sourceFile=""
    local targetFile=""
    local backupDir="$HOME/.backup_originals"
    local skipOriginalsCheck="$HOME/.dotfiles-skiporiginalscheck"


    # Shall we back up the original files?
    ask_for_confirmation "Back up current config files?"
    if answer_is_yes; then

        if [ -e $backupDir ]; then
            ask_for_confirmation "Backup dir ($backupDir) already exists, overwrite files within?"
            if answer_is_yes; then
                print_info "Will overwrite existing files in backup directory"
            else
                print_error "Please remove/rename backup dir ($backupDir) and re-run the installation script"
                exit;
            fi
        else
            mkdir -p $backupDir
        fi

        for i in ${FILES_TO_SYMLINK[@]}; do

            originalFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

            if [ -e "$originalFile" ]; then
                execute "cp -af $originalFile $backupDir/" "$originalFile → $backupDir"
            fi

        done
    else
        if [ ! -e "$skipOriginalsCheck" ]; then
            # Give the user one last chance to change their mind
            print_question "Are you sure? All the original files will be overwritten."
            print_info "Run the install script again if you are sure, this message won't appear again."
            touch "$skipOriginalsCheck"
            exit;
        fi
    fi


    # Loop through the files and symlink
    for i in ${FILES_TO_SYMLINK[@]}; do

        sourceFile="$(pwd)/$i"
        targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

        if [ -e "$sourceFile" ]; then
            if [ -e "$targetFile" ]; then
                if [ "$(readlink "$targetFile")" != "$sourceFile" ]; then

                    ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
                    if answer_is_yes; then
                        rm -rf "$targetFile"
                        execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
                    else
                        print_error "$targetFile → $sourceFile"
                    fi

                else
                    print_success "$targetFile → $sourceFile"
                fi
            else
                execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
            fi
        else
            print_error "$sourceFile is missing!"
        fi

    done

    # Git completion from https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    if [ ! -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
        cp ./git/git-completion.bash /usr/local/etc/bash_completion.d/
    fi

    # Hide the "You have mail." notification
    ask_for_confirmation "Hide the \"You have mail.\" notification?"
    if answer_is_yes; then

        touch ~/.hushlogin

    fi

}

main
