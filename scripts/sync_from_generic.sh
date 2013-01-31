#!/usr/bin/env bash
cd $(dirname $0)/..
IMPORT_URL="http://hg.foo.net"
PROJECT="paulla.plonesite"
GITORIOUS=""
GDOT="."
if [[ $(echo "$IMPORT_URL"|sed -re "s/.*gitorious.*/match/g") == "match" ]];then
    GITORIOUS="1"
    GDOT="-"
fi
GPROJECT="${PROJECT//\./${GDOT}}"
cd $(dirname $0)/..
[[ ! -d t ]] && mkdir t
rm -rf t/*
tar xzvf $(ls -1t ~/cgwb/$PROJECT*z) -C t
files="
.gitignore
bootstrap.py
buildout-dev.cfg
buildout-prod.cfg
LINK_TO_REGENERATE.html
minitage.buildout-dev.cfg
minitage.buildout-prod.cfg
README.*
minilays/
scripts/
"
for f in $files;do
    rsync -aKzv t/$f $f
done
rsync -aKzv  --exclude=versions.cfg t/etc/ etc/
policy="tests/base.py
configure.zcml
interfaces.py
profiles/default/metadata.xml"
policy_folder="src.mrdeveloper/$PROJECT.policy"
if [[ ! -e $policy_folder ]];then
    policy_folder="src/$PROJECT.policy"
fi
if [[ ! -e $policy_folder ]];then
    policy_folder="src/$PROJECT"
fi
for i in $policy;do
    rsync -azKv t/src/$PROJECT/src/${PROJECT/\./\/}/$i src.mrdeveloper/$PROJECT/src/${PROJECT/\./\/}/$i
done
EGGS_IMPORT_URL="$IMPORT_URL/eggs"
sed -re "/\[sources\]/{
        a $PROJECT =  svn $EGGS_IMPORT_URL/$GPROJECT
}" -i  etc/project/sources.cfg
sed -re "s:(src/)?$PROJECT::g" -i etc/project/$PROJECT.cfg
sed -re "/auto-checkout \+=/{
        a \    $PROJECT
}"  -i etc/project/sources.cfg
sed -re "/ Pillow/{
        a \    $PROJECT
}"  -i etc/project/$PROJECT.cfg
sed -re "/zcml\+?=/{
        a \    $PROJECT
}"  -i etc/project/$PROJECT.cfg
sed -re "s/.*:default/    ${PROJECT}:default/g" -i  etc/project/$PROJECT.cfg
sed -re "s/(extends=.*)/\1 etc\/sys\/settings-prod.cfg/g" -i buildout-prod.cfg
sed -re "/\[buildout\]/ {
aallow-hosts = \${mirrors:allow-hosts}
}" -i etc/base.cfg
sed -re "/\[mirrors\]/ {
aallow-hosts =
a\     *localhost*
a\     *willowrise.org*
a\     *plone.org*
a\     *zope.org*
a\     *effbot.org*
a\     *python.org*
a\     *initd.org*
a\     *googlecode.com*
a\     *plope.com*
a\     *bitbucket.org*
a\     *repoze.org*
a\     *crummy.com*
a\     *minitage.org*
a\     *bpython-interpreter.org*
a\     *stompstompstomp.com*
a\     *ftp.tummy.com*
a\     *pybrary.net*
a\     *www.tummy.com*
a\     *www.riverbankcomputing.com*
a\     *.selenic.com*
}" -i etc/sys/settings.cfg
sed  -re "s/dependencies=/dependencies=git-1.7 subversion-1.6 /g" -i minilays/*/*
# vim:set et sts=4 ts=4 tw=80: