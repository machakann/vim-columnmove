#! /bin/sh

VIM=vim
if [ -n "$THEMIS_VIM" ] ; then
    VIM="$THEMIS_VIM"
fi

$VIM -u NONE -i NONE -N -n -e -s -S $1 || exit 1
echo "Succeeded."
