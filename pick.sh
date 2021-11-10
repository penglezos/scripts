#!/bin/bash
source build/envsetup.sh
repopick 312889 312890 312891 # burnin protection
repopick 318057 # blur into display section
repopick 318058 # nfc icon on status bar
repopick -f 318301 # always use release-keys
repopick -t twelve-monet # monet support
