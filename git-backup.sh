#!/bin/bash
git config --global user.email "BJGarcia@gmail.com"
git config --global user.name "Brian"

cd ~
git init .
touch .gitignore
git add .gitignore
git add .
git add -f .bashrc .xsessionrc .vimrc .gvimrc .gdbinitrc  .ssh/config .local/share/applications

git commit -m 'Initial home dir checkin'

#echo "# RPI-Scale" >> README.md
#git init
#git add README.md
#git commit -m "first commit"
#git remote add origin git@github.com:Flyguy86/RPI-Scale.git
#git push -u origin master
