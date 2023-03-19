# NOTES

## GIT

```bash
git checkout -                  # Fix detached head state
git show                        # Display commit changes
git log                         # List commits
git log --all                   # List commits of all branches
git status                      # Display state of the working tree
git diff                        # Display details of changes
git diff branch_1 branch_2      # Diff between branches
git diff k73ud dj374            # Diff between oldCommit and newCommit
git add -A                      # Stages all changes
git add .                       # Stages edited and new files, without deleted ones
git add -u                      # Stages edited and deleted files, without new ones
git add -p <path>               # Interactive stage, stage parts of a file
git diff --cached               # Display cache/index changes
git commit -m "message"         # Commit changes and add a message
git commit -nm "message"        # Bypasses the pre-commit and commit-msg hooks

git commit --amend              # Change message of the last commit
git push -f                     # Update message of the last commit on the remote

                                # Change message of older or multiple commits
git rebase -i HEAD~3            # Displays a list of the last 3 commits on the current branch
                                # Then replace pick with reword before each commit message
                                # you want to change.
                                # Save and close the commit list file.
                                # In each resulting commit file, type the new commit message,
                                # save the file, and close it.
git push --force                # Force-push the amended commits.

git revert <commit-sha> && \    # Revert the last commit
git checkout <current branch>   # Then fix the detached head
git reset <file>                # Unstage staged file
git reset --hard <commit-sha>   # Delete commits after the specified one
git reset --hard HEAD~1         # Delete the last commit
git reset HEAD~1                # Undo the last commit
git push -f                     # Update the remote branche
git rm --cached <file>          # Untrack file
```

### stash

```bash
git stash                     # Save the work in progress
git stash -u                  # Save the work in progress (include untracked files)
git stash push -m "<message>" # Save the WIP with a message
git stash list                # List WIP
git stash apply stash@{0}
git stash show stash@{0}
git stash apply               # Apply last WIP
git stash drop                # Delete last WIP
git stash pop                 # Apply then delete last WIP
git stash clear               # Delete all WIP of repository
git stash -k                  # --keep-index stash not staged changes (not added to the index)
git stash -k -u               # --include-untracked stash not staged changes and new files

```

### branch

```bash
git checkout <branch>                      # Switch to the branch
git checkout -- <path-to-file>             # Delete file changes
git checkout -- .                          # Delete changes of current directory
git checkout --theirs <path-to-file>       # Accept incoming changes and ignore current changes
git checkout --ours <path-to-file>         # Ignore incoming changes and accept current changes
git checkout -b <branch>                   # Create branch and switch to it
git branch                                 # List locals branches
git branch -r                              # List remote branches
git branch -a                              # List locals + remote branches
git branch -d <branch>                     # Delete branch
git branch -m <old-branch> <new-branch>    # Rename branche
git branch -m <new-branch>                 # Rename current branch
git branch --sort=committerdate            # List of branches ordered by most recent commit
git branch --sort=-committerdate           # List of branches ordered by less recent commit
git push --all                             # Push all branches
git push --tags                            # Push all tags
git log --all --graph --decorate --oneline # Display graph
git worktree add ../<new-directory> <branch-to-checkout> # Clone the current repository to a new directory and checkout the specified branch
```

### remote

```bash
git remote set-url origin <ssh/http uri>               # Change remote URI
git remote set-url --add --push origin <ssh/http uri>  # Add a remote URI
git remote -v                                          # List remotes
git push origin <branch>                               # Create remote branch
git push -u origin <branch>                            # Create and track remote branch
git push origin -d <branch>                            # Delete remote branch
git rebase -i HEAD~1                                   # Displays the last commit on the current branch
git config --global user.name "John Doe"               # Global git user
git config --global user.email "john@doe.org"
git config user.name "John Doe"                        # Project git user
git config user.email "john@doe.org"
git config --unset branch.<branch>.remote              # Stop local branch tracking by remote branch
git push origin :<branch>                              # Delete remote branch
git ls-remote                                          # List remote branches
git log origin/<branch>                                # List remote branch logs
```

### workflow

```bash
git fetch                         # Download remote changes
git pull                          # Download and merge remote changes with locals ones
git pull --all                    # Pull all branches
git merge foo                     # Merge branch foo above the current branch
git checkout --theirs .           # Accept incoming changes (use code of the source branch)
git checkout --ours .             # Ignore incoming changes (use code of the target branch)
git rebase foo                    # Merge branch foo below the current branch
                                  # If git branch diverged after rebase, git push -f the branch
git rebase --abort                # Cancel current rebase
git push -f
git checkout <commit-sha>         # Switch to commit
git checkout <branch>             # Switch to last commit of the branch
                                  # Fix detached head state
git cherry-pick <commit-sha>      # Add commit to the current branch
git cherry-pick --abort
git cherry-pick ebe6942..905e279  # Cherry pick a range of commits (firts commit not included)
git cherry-pick ebe6942^..905e279 # Cherry pick a range of commits (include first and last commits)
git cherry-pick c307e6fbe9b8474178345639d4410eed548c2ad8^..81f0543a604a730a2c94e937d037fa234700e8e6
```

### misc

```bash
git update-index --assume-unchanged <file>        # Ignore file changes
git update-index --no-assume-unchanged <file>     # Tack file again
ssh git@<server-name>                             # Connect to server with git user
git clone https://github.com/<repository>.git     # Clone repository
git filter-branch -f --env-filter \               # Change the author of all commits
"GIT_AUTHOR_NAME='yourname'; \
GIT_AUTHOR_EMAIL='youremail@example.com'; \
GIT_COMMITTER_NAME='yourname'; \
GIT_COMMITTER_EMAIL='youremail@example.com';" \
HEAD; && \
git push --force origin master

# After deleting .git/ re-enable sync between local repository and remote without delete local files or clone remote
git init .
git remote add origin <remote url>
git fetch origin
git branch -f master origin/master
git reset . # Delete local changes
```

## DOCKER

### install
```bash
# Start docker after install
sudo systemctl start docker                   

# Start docker on boot
sudo systemctl enable docker.service          
sudo systemctl enable containerd.service

# Disable docker start on boot
sudo systemctl disable docker.service
sudo systemctl disable containerd.service
```

### base

```bash
docker-compose up --scale <service>=4 -d      # Scale service with docker-compose and nginx
docker search                                 # Search the Docker Hub for images
docker pull                                   # Pull an image or a repository from a registry
docker build --tag foo .                      # Build an image from a Dockerfile
docker-compose build                          # Force docker-compose to recreate images
docker-compose logs                           # Displays log output from services
docker-compose up -d
docker-compose up -d <servicename>
docker-compose -f docker-compose-dev.yml up -d
docker-compose down                                       # Remove containers and networks defined in the Compose file
docker-compose down --rmi all                             # Also Remove images defined in the Compose file
docker-compose stop
docker-compose rm
docker-compose start
docker-compose restart
docker-compose ps
docker logs foo                                           # List container logs
docker logs -f <container-id>                             # Display live log output
docker logs --tail 400 containername >& logs/myFile.log   # Copy the last 400 lines of logs into a file
docker inspect --format='{{.LogPath}}' <container-name>   # Show path of the container logs file
docker attach <container-id>
docker create <image>                     # Create container from image
docker start <container>                  # Start container
docker run                                # Create and start container
docker network create <network-name>      # Create network
docker network inspect <network-name>
docker network ls                         # List networks
docker network rm foo                     # Delete network
docker inspect <container id>             # Return container informations
# Return container IP
docker inspect -f '{{range .NetworkSetks}}{{.IPAddress}}{{end}}' <container>
docker images -a
docker volume create                  # Create a volume
docker volume inspect                 # Display detailed information on one or more volumes
docker volume ls                      # List volumes
docker volume prune                   # Remove all unused local volumes
docker volume rm                      # Remove one or more volumes
docker rm -v <container-name>         # Remove container and its volume
docker cp <container-id>:/file/path/within/container /host/path/target # Copy container file to the host
```

### examples

```bash
# Create container from image
docker create -it --name="wonderful_mobidock" debian:7
# Create container from image with ports and volume
docker run -d -v --restart=always $PWD:/var/www -p 82:80 klokantech/tileserver-php
docker exec -it foo bash          # Run bash in the container, i = interactive t = tty
```

### manage

```bash
docker stats                      # Display live container(s) resource usage statistics
docker ps                         # List running containers
docker ps --no-trunc              # Full labels
docker ps --format "{{.Names}}"   # Only name label
docker ps -a                      # List all containers
docker images                     # List images
docker stop                       # Stop running container
docker rm                         # Remove container
docker rm -f                      # Stop and remove containers
docker ps -a -f status=exited     # List exited containers
docker rm $(docker ps -a -f status=exited -q)    # Remove exited containers
docker rmi                        # Remove image
docker network inspect foo        # List containers of foo network
```

### clean

```bash
docker stop `docker ps -a -q`           # Stop all containers
docker rm `docker ps -a -q`             # Remove all containers
docker rmi `docker images -q`           # Remove all images
docker volume rm \                      # Remove dangling volumes
`docker volume ls -q -f dangling=true`
docker system prune                     # Remove unused containers, networks, images
docker volume prune                     # Remove unused volumes
docker image prune                      # Remove unused images
docker container prune                  # Remove unused containers
```

## NODE

### nvm

```bash
nvm ls-remote             # List available node versions
                          # Blue  = installed
                          # Green = used
nvm install node          # Install latest node release
nvm install 10.14.1       # Install specific node version
nvm use 10.14.1           # Use installed node version
node -v                   # Display used node version
killall -9 node           # Delete all node instances,
                          # helpful when a port is already taken by a node instance
```

### npm

```bash
^<version>                              # Install latest minor version or patch from specified version
~<version>                              # Install latest patch from specified version
npm install -g npm@latest               # Upgrade the latest version of npm
npm -r -g <package>                     # Uninstall global package
npm uninstall -g <package>              # Uninstall global package
npm i <package>@<version>
npm i <package>@<tag>
npm i https://github.com/xjamundx/eslint-plugin-promise.git --save # Install specific branch
npm i -g npm@latest                     # Install latest npm version
npm i <package>                         # Package will appear in your dependencies
npm i -D <package>                      # Package will appear in your devDependencies
npm i -E <package>                      # Install package with exact version
npm i --no-optional                     # Prevent optional dependencies from being installed
npm r -S <package>                      # Remove package from dependencies
npm r -D <package>                      # Remove package from devDependencies
npm outdated                            # List outdated packages
npm up                                  # Update minor versions of packages
npm i -g npm-check-updates && \         # Update all packages
ncu -u && \
npm up
npm up -g                               # Update global packages
npm cache clean -f                      # Clean local npm cache which is stored in ~/.npm/_cacache
npm cache verify
rm -rf node_modules
npm dedupe                              # Fix dependencies errors
npm ls <package>                        # List package and his dependencies
npm ls --depth=0 | grep <package>       # List package without his dependencies
npm ls --depth=0                        # List local packages
npm ls -g --depth=0                     # List global packages
```

## BASH

### usb boot

```bash
df -h                           # Liste les volumes et repère la clé à écrire
umount /run/media/<user>/A      # Démonte la clé à écrire
sudo fdisk -l                   # Liste les volumes et repère le nom du volume de la clé à écrire
sudo dd bs=4M if=/home/<user>/Downloads/<image_system>.iso of=/dev/sda1 && sync	# Ecrit l'image système sur la clé usb
```

### chroot
```bash
https://forum.endeavouros.com/t/the-latest-grub-package-update-needs-some-manual-intervention/30689
sudo fdisk -l
lsblk
sudo cryptsetup open /dev/nvme0n1p2 crypto_LUKS
sudo mount /dev/mapper/crypto_LUKS /mnt
sudo mount /dev/nvme0n1p1 /mnt/boot/efi
sudo arch-chroot /mnt
```

### access rights

```bash
su                                         # Se connecter en tant que superutilisateur
su <user>                                  # Se connecter en tant qu’utilisateur

cat /etc/passwd | awk -F: '{print $ 1}'    # Liste les utilisateurs
cat /etc/group | awk -F: '{print $ 1}'     # Liste les groupes
cat /etc/group | awk -F: '{print $ 3 $ 1}' # Liste les groupes + gid
grep '<group>' /etc/group                  # Liste les utilisateurs du groupe
sudo usermod -aG <group> <user>            # Ajoute l'utilisateur au groupe
groups <user>                              # Liste les groupes de l'utilisateur
newgrp <group>                             # Change l'id actuel du groupe
# Change le groupe et l'utilisateur propriétaires du fichier
# chown = change owner
chown <owner>:<group> /home/<user>/Documents/<file>
chown <owner>:<group> /home/<user>/Documents/<directory>/*
# Change récursivement le groupe et l'utilisateur propriétaires du répertoire
chown -R <owner>:<group> <folder>
```

### drivers install

```bash
synaptic                              # Outil graphique de gestion des paquets
lspci                                 # Affiche les périphériques de la machine
uname -a                              # Renvoie version linux et kernel
lspci -nn | grep -i network           # Renvoie carte wifi
lspci -k | grep -i network -A 2       # Renvoie carte wifi et pilote wifi
lspci | grep VGA                      # See GPU detected
lspci -nn | egrep -i "3d|display|vga" # See GPU detected (hybrid GPU)
mhwd -l -d                            # See installed GPU drivers
glxinfo | grep OpenGL                 # See what GPU is currently used
dmesg                                 # Affiche les messages du kernel
nmap -sP 192.168.0.0/24               # Affiche les adresses ip des machines connectées au réseau
```

### packages install

```bash
ln -s /path/<source-directory> <link-name>   # Se placer dans le répertoire dans lequel on souhaite créer le lien
ln -s /path/<source-directory> /path/<link-name>   # Ou alors utiliser des chemins absolus
snap install <package>            # Installe l'application avec l'utilitaire snap
snap remove <package>             # Désinstalle l'application
vi /etc/apt/sources.list          # Ajouter les dépôts non free https://wiki.debian.org/fr/SourcesList
apt install firmware-iwlwifi      # Puis installer le pilote wifi (pilote intel est non free)
                                  # Puis redémarer la machine
/etc/apt/sources.list.d           # Répertoire des dépôts
ln -s /opt/sublime_text/sublime_text /usr/bin/sublimetext   # Création d’un lien symbolique pour lancer les applications
/opt                              # Répertoire des applications
dpkg -i *.deb                     # Installe tous les paquet .dep
apt --fix-broken install          # Installe les dépendances manquantes s'il manque des packages requis lors de l'installation des applications
sudo apt remove --purge           # Désinstalle package
sudo aptitude remove program      # Désinstalle package
apt update                        # Mise à jour de la liste des paquets
apt full-upgrade                  # Installation des paquets de la liste et de leurs dépendances
dpkg --list                       # Liste packages installés
apt-cache search                  # Recherche une chaîne de caractères dans la liste des paquets connus
apt list -a --installed <string>  # Search for packages with the specified string in their name
chmod a+x exampleName.AppImage    # Change mode, donne l'autorisation d'execution à tous les utilisateurs
apt clean                         # Vide le cache des paquets
```

### custom functions

```bash
vi ~/.custom_commands.sh          # Create or change the script
source ~/.custom_commands.sh      # Add the following command after the last line of the ~/.bashrc
                                  # to load the script during each interactive shell launch
```

### ssh keys

```bash
# Generate ssh key pair

ssh-keygen -t ed25519 -C "email@example.com"        # ED25519
ssh-keygen -t rsa -b 4096 -C "email@example.com"    # RSA
                                                    # ssh-keygen -t rsa -b 2048

ssh-keygen -p -f <keyname>                          # Change ssh key password
ssh-add ~/.ssh/id_rsa                               # Add private key to the ssh-agent
ssh-add -l                                          # List keys added to the ssh-agent
ssh-keygen -lf <path-to-private-key>                # Check key signature
ssh-add -d <path-to-private-key>                    # Remove private key from the ssh-agent
ssh-add -D                                          # Remove all private keys

chmod 600 ~/.ssh/id_rsa                             # In case access to the server is denied, maybe file permissions are too open

# Add the public key on the server

su
adduser <new-user-name>
mkdir <new-user-name>/.ssh
touch <new-user-name>/.ssh/authorized_keys
# Puis ajouter la clé plublique copiée sur le serveur
# dans le fichier authorized_keys de l'utilisateur
# Vérifier que l'utilisateur y a accès en lecture
# Ou
cat /home/<user>/id_rsa.pub >> ./authorized_keys
```

### utility

```bash
localectl # system locale and keymap
localectl list-x11-keymap-variants us # List us layout variants
localectl --no-convert set-x11-keymap us # Set us layout
localectl --no-convert set-x11-keymap us "" altgr-intl # Set us layout with variant
who    # List user sessions
which
command -v <the-command> # check if command exist
whereis <file>
date # Display current date and time
```

### files operations

```bash
cd -                                        # Revient au répertoire précédent
mkdir -p foo                                # Créé un répertoire et ses répertoire parents
mkdir <directory> && cp $_
rm -rf foo/*                                # Supprime le contenu du dossier
rm *<text>*                                 # delete files with the <text> pattern
pacman -<file> <newfilename>                # Renomme le fichier
pacman -Qdtq                                # Find out all packages that don’t depend on other packages
sudo pacman -R $(pacman -Qdtq)              # Remove these unnecessary packages
downgrade <package>                         # Downgrade the package
mv <directory> /home/<user>/Documents      # Déplace le répertoire et son contenu
                                            # déplace les répertoires 1, 2 et 3 et leur contenu
mv <directory1> <directory2> <directory3> /home/<user>/Documents
mv <file> <directory>\                                 # Déplace le fichier dans le répertoire
mv <file> <file> <directory>\                          # Déplace plusieurs fichiers dans le répertoire
cp -r /<directory>/                                    # Copy directory and his dotfiles
cp -r ~/Desktop/<directory> ~/Documents/<directory>    # Copie le répertoire en incluant les fichiers cachés
mkdir -p ~/.local/share/nvim/site/plugin               # Create a directory and its parent directories
                                                       # (ne pas spécifier les fichiers du répertoire)
cp /<source-directory>/* /<target-directory>/          # Copie de tous les fichiers d'un répertoire vers un autre répertoire
cp <file-1> <file-2> /<target-directory>/              # Copy multiple files into a directory
rm -rf <directory>/*                                   # Supprime tout le contenu du répertoire

scp -r -P <port> <user>@<server>:<chemin/vers/dossier/source> .  # Copie du serveur vers le répetoire courant
scp <port> <user>@<ip>:/home/<user>/<file-name>.log .            # Copie du serveur vers le répetoire courant
scp -r -P <port> . <user>@<server>:<chemin/vers/dossier/source>  # Copie du répertoire courant vers le serveur
rsync --info=progress2 <source> <dest>    # Copie un fichier et donne un % de progression
rsync --progress <source> <dest>          # Copie un fichier et donne un % de progression
rsync -avz -e "ssh -p<port>" \
--exclude ".git" --exclude "node_modules" --exclude ".nuxt" --exclude ".env" \
./tileserver-gl/ <user>@<ip>:/home/<user>/tileserver-gl/
chmod 777 <file>                          # Donne tous les droits au fichier
chmod 755 <file>
unzip <file name>.zip                     # Décompresse le fichier
unzip <file name>.zip -d <destination directory>
tar xvzf <file name>.tar.gz -C <destination directory>
display <image.png>                       # Open image
xdg-open <file.pdf>                       # Open pdf
```

### files encoding

```bash
# Convert file from latin1 to utf8
file -i <file> # Return file encoding
iconv -f LATIN1 -t UTF-8 <input-file> -o <output-file> # When encoding is unknown

# Detect the encoding of a file by specifying its language or not
enca -L ru <file>
enca -L none <file>

# Convert file dos / unix / mac
dos2unix <file>
:set fileformat=unix # (dos to unix) with vim
mac2unix <file>
unix2dos <file>
unix2mac <file>
```

### informations

```bash
du -h <file>                        # Affiche la taille d'un fichier
du -sh <directory>                  # Affiche la taille d'un répertoire
du -sh /home/utilisateur/*          # Affiche la taille des fichiers et répertoires d'un répertoire
ls -a                               # Affiche les fichiers cachés
ls ./*                              # Show all files in subdirectories of the current directory
ls -l                               # Liste les fichiers et leurs droits d'accès
ls -hal                             # Liste tous les fichiers et leurs droits d'accès
ls -halt                            # Sort by modification time, newest first
ls -haltr                           # Reverse order while sorting
sensors                             # Display temperatures
lscpu                               # Display CPU informations
htop                                # Display CPU & RAM usage
xprop WM_CLASS                      # Get class of clicked window for use with picom
```

### search

```bash
find . |  xargs  grep  'The Big Brains Company' -sl   # Recherche les fichiers qui contiennent une chaine de caractères
fd -l . /nix/store | grep 'tmux-plugins'
ps -ef | grep xcap              # search xcap process among all processes (full format)
-s, --no-messages               # Suppress error messages about nonexistent or unreadable files
-l, --files-with-matches        # suppress normal output, instead print the name of each input file
                                # from which output would normally have been printed
                                # The scanning will stop on the first match
sudo find / -type f -newermt 2018-11-26 ! -newermt 2018-11-27 -ls   # cherche tous les fichiers modifiés à une date donnée
sudo find / -name "*.ppk" -type f                 # Cherche les clées .ppk
find . -name "*.vim" -type f
find /path/to/folder/ -iname *file_name_portion*  # Search file (case insensitive)
<cmd> | grep foo                                  # Filtre le résultat de la commande sur les caractères "foo"
grep -i "fontface" /etc/default/console-setup     # Cherche les lignes avec le mot
grep -rnw '/path/to/somewhere/' -e 'pattern'      # Cherche un pattern et retourne les informations des fichiers le contenant
                                                  # "fontface" en ignorant la casse
grep "Site du Zéro"                               # Fichier.ext recherche la chaîne de caractères dans le fichier
```

### shell

```bash
chsh -l                    # List shells
chsh -s <shell>            # Changes the user login shell
chsh -s /bin/bash          # Set bash as the user login shell
source ~/.bashrc           # Reload the .bashrc into the current shell
```

### processes

```bash
kill -TSTP <PID>                  # Pause le processus
kill -CONT <PID>                  # Relance le processus
kill -9	<PID>                     # Tue le processus dont le PID a été spécifié
kill -9 -1                        # Tue tous les processus
sleep 600 &                       # Lance un processus de 600 secondes
lsof -ti tcp:8085 | xargs kill -9 # Kill process runing on specified port
```

### misc

```bash

efibootmgr                          # List boot entries
efibootmgr -b 0001, 0004 -B         # Change boot order
pkill -KILL -u <session>            # Kill user session
sudo vi /etc/hosts                  # Add an host
[<user>@<machine> ~]$               # '$' signifie connecté en tant qu'utilisateur
[<machine> <user>]                  # '#' signifie connecté en tant que root
setxkbmap fr                        # Change le clavier en azerty à partir d'un émulateur de terminal
loadkeys fr                         # À partir d'une console
xxd -psd                            # Print key combination hex code
xmodmap -pke | grep Enter           # Search for key code
super + l                           # Mise en veille de la machine
clear                               # Efface le terminal
reset                               # Réinitialise le terminal
ctrl + alt + F2                     # Passe en mode tty
ctrl + alt + F3                     # Passe en mode gui
umount /media/<périphérique>        # Démonte le périphérique
lsblk                               # List block devices
lsblk -o NAME,FSTYPE,LABEL,MOUNTPOINT,SIZE,MODEL # More info
udisksctl mount -b /dev/sda         # Mount device
udisksctl unmount -b /dev/sda       # Unmount device
gnome-terminal                      # Ouvre un terminal gnome

passwd user                               # Change le mot de passe de l'utilisateur
fuser scan.log~                           # Liste les programmes qui utilisent ce fichier
nohup                                     # Lance une commande en arrière plan (indépendamment de la console)
Ctrl + r                                  # Recherche dans l’historique des commandes

# Pour effacer complètement l'historique de l'utilisateur courant
~/.bash_history                           # Efface l’historique des commandes
# ou alors
history -c                                # Efface l'historique de la session courante
history -w                                # Remplace l'historique général des commandes
                                          # par l'historique du shell courant (que vous venez d'effacer)

apt <package> -y            # Accepte toutes les demandes lors de l'installation
<command> | less            # Affiche tout le contenu de la commande
base64 -d <file> > file     # Decode base64 file
base64 <file>               # Encode file content to base64
echo <string> | base64 -d   # Decode base64 value
echo  <string> | base64     # Encode value to base64
showkey -a                  # Show pressed key
sudo xinit -- :1            # Run a X server with only an xterm,
xev                         # then print contents of X events
wget -nd -r -H -p -e robots=off -P <destination path> -A jpeg,jpg,png  <site url> # Download all images from a url
```

### fonts
```bash
fc-list # Affiche la liste des polices installées sur le système
# Download font in /usr/share/fonts
# Then update the fontconfig cache
fc-cache

# gnome
vim /etc/default/console-setup      # Modifie les paramètres des TTY virtual consoles tels que la police
# Pour changer la police des terminaux gnome se connecter en tant qu'utilisateur puis
gsettings get org.gnome.desktop.interface monospace-font-name                # Affiche la police actuellement installée dans les terminaux gnome
gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace 20' # Change la police des terminaux gnome
```
### create a shell script

```bash
!/bin/bash                  # Ajouter au début du fichier .sh
chmod +x <file name>.sh     # Le rentre exécutable
./<file name>.sh            # Exécuter le fichier
```

### disks

```bash
df -h                                     # Taille du disque
du  -h  -d  1 ~/                          # Utilisation des disques (1 niveau de répertoires)
ncdu ~/                                   # Permet de naviguer dans les fichiers/répertoires et de connaître leur place
sudo parted -l                            # Liste les disques
fdisk -l                                  # Liste tous les disques du système
badblocks -v /dev/mmcblk0p1               # Corrige les secteurs défectueux
mkfs.vfat -F32 /dev/mmcblk0p1 -l CRISTAL  # Formate le disque en FAT32 (version fat la plus récente)
```

## VIM

### commands

```
:e /path/to/file            # Edit file
:!<cmd>                     # Lance une commande dans le shell depuis vim
:tabe                       # Open a new tab
:term                       # Open a terminal
:tabe | term                # Open a terminal in a new tab
:!<cmd>                     # Lance une commande dans le shell depuis vim
:left                       # Formate la ligne
:%le                        # Formate toutes les lignes du fichier
:noh                        # Désactive le surlignage de la recherche
:scriptnames                # List all plugins, _vimrcs loaded
:colorscheme spacegrey      # Change le thème
:%s/<str1>/<str2>/g         # Remplace toutes les occurences de str1 par str2
:s/<str1>/<str2>/           # Remplace toutes les occurences de str1 par str2 sur les lignes sélectionné en visual mode
:%s/\'\([^']*\)\'/"\1"/g    # Remplace toutes les single quotes par des double quotes
:s/,/\r&/                   # Ajoute une nouvelle ligne après chaque virgule
:reg                        # Show the contents of all registers
:sort u                     # Trie les lignes et supprime celles en double
:NERDTree                   # Ouvre la fenêtre nerdtree
:NERDTreeFocus
:NERDTreeToggle
:e /pah/to/file             # Ouvre le fichier depuis vim
:join                       # Fusionne plusieurs lignes en une seule et les sépare avec un espace
:join!                      # Pareil mais sans séparateur
:norm $xx                   # Delete the two last characters of selected lines
:norm A<text-to-append>     # Append text at the end of selected lines
:%norm A*                   # Add * at the end of each line
:helptags ALL               # Generate helptags for all packages
:ALEInfo                    # Check ALE configuration for the current file
:CocInstall coc-highlight   # Uninstall coc plugin
:CocUninstall coc-highlight # Uninstall coc plugin
:delm!                      # Delete all marks
:sort                       # Sort alphabetically visual selection
```

### keys

```
<c-z>
fg
bg
q                           # Start/stop recording
ctrl j                      # Navigue entre les erreur ale
ctrl k
zfa}                        # Fold current block
zR                          # Open all folds
zM                          # Close all folds
zE                          # Delete all folds
saveas                      # Sauvegarde le fichier courant dans le CWD
u                           # Annule l'action précédente
ctrl r                      # Annule l'action annulée
=                           # Réindente les lignes sélectionées en mode visuel
gg=G                        # Réindente tout le fichier
>                           # Indente la ligne
>                           # Désindente la ligne
yl                          # Copie le caractère
x                           # Supprime le caractère
yy                          # Copie la ligne
yap                         # Copie tout le paragraphe
v                           # Sélectionne des caractères
V                           # Sélectionne des lignes
ctrl v                      # Sélectionne un block
gx                          # Open a link
ctrl j                      # Navigue entre les erreur ale
wqa                         # Sauvegarde tous les fichiers et les quitte
w                           # Move at the beginning of the next word
ge                          # Move at the end of the previous word
ctrl ww                     # Passe de la fenêtre nerd tree à la fenêtre de l'éditeur
ctrl b                      # Scroll up
ctrl bb                     # Scroll up when use vim with tmux
ctrl f                      # Scroll down
ctrl g                      # Relative path
1 ctrl g                    # Absolute path
I                           # Insert at the beginning of the line
gi                          # Sépare horizontalement sans éditer
s                           # Sépare verticalement
gs                          # Sépare horizontalement sans éditer
gt                          # Tab suivante
gT                          # Tab précédente
5gt                         # Tab 5
D                           # Supprime la ligne à partir du curseur
dd                          # Supprime la ligne du curseur
daw                         # Supprime le mot sur le curseur
diw
caw                         # Supprime le mot sur le curseur et passe en mode édition
ciw
ci'                         # Change text inside ''
caw                         # Supprime le mot sur le curseur et passe en mode édition
yaw
yiw
u                           # Annule la dernière action
r                           # Remplace le caractère sous le curseur par un caractère saisi
/                           # Recherche
p                           # Colle avant le curseur
"ayaw                       # Copie d'un mot dans le buffer a
"ap                         # Colle avant le curseur le contenu du buffer a
"+yy                        # Colle la ligne dans le buffer du système
P                           # Colle après le curseur
I                           # Affiche les fichiers cachés
~                           # Change la casse
gl<character>               # Aligne les lignes sélectionnées à partir du caractère
gL<character>
5e                          # Déplace le curseur sur la dernière lettre du 5e mot
b                           # Déplace le curseur sur la première lettre du mot
B                           # Déplace le curseur sur la première lettre du mot (mot = tout ce qui n'est pas un espace)
%                           # Range representing the entire file
norm                        # Normal mode
A*                          # Insert at the end of line
ctrl p                      # Autocomplétion
ctrl p                      # Match suivant
ctrl n                      # Match précédent
ctrl A                      # Incrémente le nombre
ctrl X                      # Décrémente le nombre
e
Ctrl + Z                    # Will suspend the process and get back to your shell
fg                          # Déplace le curseur sur la dernière lettre du mot ( mot = lettres, nombres & underscores)
```

### plugins

```
crs       # snake_case
crm       # MixedCase
crc       # camelCase
cru       # UPPER_CASE
cr-       # dash-case
cr.       # dot.case
cr<space> # space case
crt       # Title Case

cs"'
cs'<q>
cst"
ds"
ciwspan<esc>  # <div></div> => <span></span>
```

### debug

```
:checkhealth
nvim -V10nvim.log           # nvim logs
:verbose set fo             # debug init.vim
:verbose inoremap <esc>     # debug init.vim
:messages                   # error messages
:highlight                  # highlight groups
:filter BufferLine highlight
:so $VIMRUNTIME/syntax/hitest.vim # highlight groups in a new window
:echo &ft                   # display file type
```


### nerdtree

```
m                           # NERDTree modifie le fichier / répertoire
cd                          # Définit le current working directory
o                           # Ouvre
go                          # Ouvre sans éditer
t                           # Ouvre dans une tab
T                           # Ouvre dans une tab sans éditer
i                           # Sépare horizontalement
```

### misc

```
sudo pacman -S xclip        # Install clipboard
```

## FIREBASE

### Hosting

```bash
npm install -g firebase-tools
firebase login
firebase logout                # if logged with wrong account
firebase init
npm run build
firebase deploy --only hosting # Deploy project on Firebase Hosting
firebase serve --only hosting  # Serve files on localhost
firebase emulators:start --only functions # Serve functions on localhost

firebase use <project_id>

```

## qmk

```
qmk config
qmk new-keymap
qmk compile -kb ferris/sweep -km runeword
qmk flash -kb ferris/sweep -km runeword -bl dfu-split-left
qmk flash -kb ferris/sweep -km runeword -bl dfu-split-right
qmk json2c -o _keymap.c keymap.json
```

## NIXOS
https://www.youtube.com/watch?v=AGVXJ-TIv3Y
```bash
# Install package on the system
sudo nvim /etc/nixos/configuration.nix
sudo nixos-rebuild switch

# Install package on the system as a service
sudo nvim /etc/nixos/configuration.nix
services.plex.enable = true
sudo nixos-rebuild switch

# Install package on the system, must be managed by the user
nix-env -iA <package_name> # Install package
nix-env -q # List packages installed with nix-env
nix-env --uninstall <package_name> # Uninstall package

# Update system
nix-channel --update
sudo nixos-rebuild switch --upgrade # Apply changes

# Add home manager as a nixos module
sudo nix-channel --add <url>/master.tar.gz home-manager # Add home-manager channel for root user
nix-channel --add <url>/master.tar.gz home-manager # Add homme-manager channel on a user level
# sudo nix-channel --remove home-manager
nix-channel update # Build the channel
sudo nvim /etc/nixos/configuration.nix # Add home manager to imports + check for a user
# Add packages to home manager
home-manager.users.${user} = { pkgs, ... } : {
    home-packages = [ pkgs.hop ];
};
# Then rebuild
sudo nixos-rebuild switch


# Add home manager standalone
nix-channel --add <url>/master.tar.gz home-manager # Add homme-manager channel on a user level
nix-shell '<home-manager>' -A install
# Add some package :
# home.packages = with pkgs; [ htop ];
# Or add some services :
# services.dunst = {
#     enable = true;
# }
nvim .config/nixpkgs/home.nix
home-manager switch

# Remove specific system generation
nix-env --list-generations
nix-env --delete-generations 2
# Remove all system generations
sudo nix-collect-garbage -d

# Flakes
sudo nvim /etc/nixos/configuration.nix
nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
};
sudo nixos-rebuild switch
# Create a flakes directory
mkdir flakes
cd flakes
nix flake init
nvim flake.nix

# Documentation
man configuration.nix
man home-configuration.nix

# List installed packages
ls /nix/store/ | grep "typescript"
```

## gcloud

```bash
gcloud auth login
gcloud projects list
gcloud config set <project name>
gcloud config set compute/zone <zone name>
gcloud config set compute/region <region name>
gcloud container clusters get-credentials <cluster name>
```

## gsutil

```
gsutil ls  # List buckets of the current project
gsutil cp -r gs://<source bucket>/2022-01-02T18:36:08_85547 gs://<destination bucket>/2022-01-02T18:36:08_85547 # Copy object to another bucket

```

## VUE

### vue-cli

```bash
vue ui
```

### eslint

```bash
npm run lint ./app/components/<file_name>.vue   # check file syntax
eslint --fix <path to file>                     # fix eslint errors
npm run lint -- --fix                           # fix eslint errors for all project files
```

## TOOLS

### npm packages

```bash
# debug
# Application => Storate => Local Storage => http://localhost:8080
localStorage.debug = '*';
localStorage.debug = 'app:*';

# json2csv
npm install -g json2csv
json2csv -i <input-file-name>.json -F -o <output-file-name>.csv
```

### rg

```bash
rg -e <pattern>
```

### fzf

```bash
# To install with with git (with pacman install fzf do not work with tmux)
```

### gitolite

```bash
1. Clone the gitolite repository on your local machine
2. In the repository add the new user to the 'dev' group in the gitolite.conf file
3. Add the user public key to the directory 'keydir/main'
4. Commit and push
```

## ARCH

```bash
pacman -Ss <package>                 # Search a package
sudo pacman -S <package>             # Install a package
pacman -R <package>                  # Uninstall a package
sudo pacman -Syyu                    # Rebuild the list of packages then updates the system
cat /var/log/pacman.log              # Get a chronological list of everything pacman has done
yay -Ql <package-name>               # Search files installed by a package
```

## JAVASCRIPT

### arrays

```javascript
// Concatenate 2 arrays
let array3 = array1.concat(array2)  // ES5 concatenate
let array3 = [...array1, ...array2] // ES6 destructuring

array1.includes(array2))            // Filter with another array
let array2 = array1.slice()         // Shallow copy
[...new Set(array1)].length         // Deduplicate
array1.splice(index, 0, value)      // Add a value to a given index
array1.splice(index, 1, value)      // Replace element of the given index
arr.splice(new_index, 0, arr.splice(old_index, 1)[0]) // Reorder array
Array(5).fill(2) // Create an array and fill it with one value
                 // => [2, 2, 2, 2, 2]
const objectToSet = array1.find(object => object.id === <condition>)
objectToSet.propertyToSet = valueToSet

// JavaScript object with max length

// Do not work on huge arrays
const objects = [{ a:1, b:2 }, { a:5 }]
const objectWithMaxLength = objects[objectsLength.indexOf(Math.max(...objectsLength))]
// Work on huge arrays
const objectsLength = objects.map(object => Object.keys(object).length)
const maxLength = objectsLength.reduce((a, b) => Math.max(a, b))
const objectWithMaxLength = objects[objectsLength.indexOf(maxLength)]
```

### objects

```javascript
const object1 = {...object2}                  // Shallow copy
object1 = JSON.parse(JSON.stringify(object2)) // Deep copy
object1.key1 = value1                         // Add property at the end
Object.assign({ key1: value1 }, object1)      // Add property at the beginning
// Pick object properties
const object1 = { property1, property2, property3 }
const object2 = (({ property2, property3}) => ({ property2, property3 }))(object1);
_omit
```
### regex

```javascript
/[^article ].*(?= :| –)/gi
// ARTICLE <<UDa 10>> : HAUTEUR MAXIMUM DES CONSTRUCTIONS
// <<UA.4>> – Conditions de desserte des terrains
/[^–|:]*$/
// ARTICLE UDa 10 :<<  HAUTEUR MAXIMUM DES CONSTRUCTIONS >>
// UA.4 –<<  Conditions de desserte des terrains >>
/ (?!^)/
// articles<<   >>de la grande
/article(?= )/
// ARTICLE UDa 10 : HAUTEUR MAXIMUM DES CONSTRUCTIONS
/.*(?= :| –| -|)(.*(:|-|–|\.) )/
/ : | - | – |\. /i
// ARTICLE UAa 1 : OCCUPATIONS ET UTILISATIONS DU SOL INTERDITES
```

## POSTGRES

### psql

```bash
docker exec -it <container-name> psql -d <db> -U <db-user>            # Connect to the database
docker exec -i <container-name> psql -d <db> -U postgres -c '<query>' # Execute a query with psql of the container
\l or \list            # List all databases
\c <database>          # connect to the database <database>
\d                     # Display all pg objects
\dt                    # Display all tables for the current database
\dt <schema>.          # List tables into the schema
\dt                    # Then list tables of the schema
\dt *.                 # list tables of all schemas
\dx                    # List all extensions
 ```

### dump

```bash
docker exec <container-name> pg_dump -U postgres -d <db> --format=t > 19.11.21.tar  # Dump whole database
docker exec <container-name> pg_dump -U postgres -s <db> > schema.dmp               # Dump schema (without data) for a whole database
docker exec <container-name> pg_dump -U postgres -s <db> -t <table> > schema.sql    # Dump schema (without data) for a table
```

### restore

```bash
docker exec -i <container-name> pg_restore -U postgres -d <db> < 19.12.15.tar                        # Restore database from a db dump
docker exec -i <container-name> pg_restore -U postgres --data-only -d <db> -t <table> < 19.11.28.tar # Restore table from a db dump
```

### queries

```sql
CREATE DATABASE <db>;
DROP DATABASE <db>;
SELECT * FROM <table>;                          -- Query table
SET search_path TO <schema>, public;            -- Set path to the schema
CREATE USER <user>;                             -- Create user
ALTER USER <user> WITH superuser;               -- Grant superuser permissions to the user
SELECT * FROM pg_extension;                     -- List all installed extensions
CREATE EXTENSION pgcrypto;                      -- Create extension with schema of the path (default public)
CREATE EXTENSION pgcrypto WITH SCHEMA public;   -- Create extension with schema public
DROP EXTENSIONS pgcrypto;
SHOW TIMEZONE;
-- Add a user
INSERT INTO <schema.table> (name, password, email) VALUES ('<name>', crypt('<password>', gen_salt('bf')), '<email>');
-- Delete a user
DELETE FROM auth.auth WHERE name = <name>;
-- Change user password
UPDATE <schema>.<table> SET password = crypt('<password>', gen_salt('bf')) WHERE name = '<name>';
```

## CONFIG

```bash
# /etc/lightdm/lightdm.conf
# typematic delay and rate
server-command=X -ardelay 250 -arinterval 20
```

## QMK

```bash
qmk compile -kb ferris/sweep -km dvorak
qmk flash -kb ferris/sweep -km dvorak
```
