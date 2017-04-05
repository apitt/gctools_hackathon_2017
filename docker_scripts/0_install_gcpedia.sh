#Create a directory for Mariadb service
if [ ! -d "data" ]; then
    mkdir data
fi

#clone GCPedia code if not already done:
if [ ! -d "gcpedia" ]; then
    echo '*** Getting GcPedia code ***'
    git clone https://github.com/gctools-outilsgc/gcpedia.git
fi

cd gcpedia

#install Wikimedia dependencies if not already done:
if [ ! -d "vendor" ]; then
    echo '*** Getting Vendor code ***'
    git clone https://gerrit.wikimedia.org/r/p/mediawiki/vendor.git 
fi

#TODO: I should verify why this file is causing some variables to be duplicated in the php site.
#But, for now, we will just delete its content.
cd vendor/wikimedia/timestamp/src
echo '<?php' > defines.php




