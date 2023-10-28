#!/bin/sh

mkdir -p tmp
unzip -df "tmp" demo.ipa

ls -al tmp/opmini/
ls -al tmp/opmnini/Payload/*.app/
cp -rf tmp/opmnini/Payload/*.app tmp/opmnini/Payload/extracted_app

# tree demo 

# ...
# languages: *.lproj/
#     localizable strings
# resources/assets: *.png
# configs: *.plist
# _CodeSignatue/CodeResources
# ...