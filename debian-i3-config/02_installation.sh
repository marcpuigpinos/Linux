#!/bin/bash

echo "Copying configurations..."
cp .bashrc ~/.bashrc
cp -r .config ~/.config
cp -r .emacs.d ~/.emacs.d
echo "Finished task"
