#!/bin/bash

PKG="$@"

PKGNAME="$(grep-available -sPackage -sVersion -sDescription . /var/lib/apt/lists/*_Packages | grep -A 2 -E "^Package\: .*${PKG}" | awk '{$1="";print $0}' | zenity --list --width=900 --height=550 --column="Package" --column="Version" --print-column=1 --column="Description" --column="" --hide-column=4 --title "search packages" --text "Packages found:")"

[[ -n ${PKGNAME} ]] && apt-cache show $PKGNAME | zenity --text-info --title="info $PKGNAME" --width=800 --height=500
