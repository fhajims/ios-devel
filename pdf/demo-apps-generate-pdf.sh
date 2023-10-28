#!/bin/zsh

# convert markdown to one single PDF

OUT="demo-apps"


# Note when "designing" the markdown files with HEADER and FOOTER:
#
# HEADER: the header 
#         needs THREE DASHes (---) to make header/footer links work on git
#         needs an empty line followed by
#         needs THREE DASHes (---) to make header/footer links work on git
#         needs in the second line THREE DASHes (---) to be ignored by pandoc
#         needs a caption h4 with #### for the home links etc
#         needs an empty line followed by
#         needs another three dashes (---) to end the section ignored by pandoc
#    
# ---
# #### [Home](./README.md) | [Overview](./study-material--overview.md)
# 
# ---
# Footer: better use also a small heading (h4 ####) within thre (---) for being ignored by pandoc
# --- 
# #### [Back home](./README.md)
# ---

# Requirements: pandoc

# see: https://pandoc.org/MANUAL.html#pandocs-markdown 

# Set some dynamic variables to create a dynamic meta-info-file
# Note: /usr/local/bin/envsubst required
export CURRDATE=$(date +'%Y-%m-%d') # 2022-01-27
command -v envsubst >/dev/null && { # if envsubst is available, we update metadata.md
  cat  pandoc-data-dir/metadata-demoapps.template.txt | envsubst > pandoc-data-dir/metadata-demoapps.md
}


# Note: see config.yaml for further (default) configuration
# Note: see metadata.md (possibly, generated from metadata.template.txt) for Title, Subtitle, author, ....

# do not modify anything below this line


echo "We convert the *.md to a PDF file with pandoc..."
pandoc\
  --data-dir=pandoc-data-dir\
  --defaults=pandoc-data-dir/config-demoapps.yaml\
  --resource-path=pandoc-data-dir\
:../\
:../chapter-01-intro\
:../chapter-01-intro/PackageManager\
:../chapter-01-intro/AppLifeCycle\
:../chapter-01-intro/SlideShowApp\
:../chapter-01-intro/SlideShowApp-Refactoring\
:../chapter-02-testing/UnitTesting\
:../chapter-02-testing/UnitTestingWithPerformanceMeasuring\
:../chapter-02-testing/UITesting\
:../chapter-05-gui/\
:../chapter-05-gui/Widgets\
:../chapter-05-gui/Accessibility\
:../chapter-05-gui/Tabs\
:../chapter-05-gui/Lists\
:../chapter-05-gui/Navigation\
:../chapter-05-gui/Layouts\
:../chapter-05-gui/Localisation\
:../chapter-05-gui/DataBinding\
:../chapter-05-gui/UnitTesting\
:../chapter-06-concurrency/Concurrency\
:../chapter-06-concurrency/GCD\
:../chapter-06-concurrency/run-heros-api-webservice-locally\
:../chapter-07-persistency/Persistency\
:../chapter-08-location/Location\
:../chapter-09-animation/Animation\
:../chapter-10-sensors/QR-Scanner\
:../chapter-12-system/URLSchemes\
:../chapter-12-system/Sharing\
  --toc\
  --listings\
  --include-in-header pandoc-data-dir/listings-setup.tex \
  --lua-filter=pandoc-data-dir/fix-links-multiple-files.lua\
  -f markdown\
  -t pdf\
  -o "${OUT}.pdf"\
  pandoc-data-dir/metadata-demoapps.md\
    ../demo-apps.md\
    ../chapter-01-intro/README.md\
    ../chapter-01-intro/PackageManager/README.md\
    ../chapter-01-intro/AppLifeCycle/README.md\
    ../chapter-01-intro/SlideShowApp/README.md\
    ../chapter-02-testing/README.md\
    ../chapter-02-testing/UnitTesting/README.md\
    ../chapter-02-testing/UnitTestingWithPerformanceMeasuring/README.md\
    ../chapter-02-testing/UITesting/README.md\
    ../chapter-03-swift/README.md\
    ../chapter-04-data-modelling/README.md\
    ../chapter-05-gui/README.md\
    ../chapter-05-gui/Widgets/README.md\
    ../chapter-05-gui/Accessibility/README.md\
    ../chapter-05-gui/Tabs/README.md\
    ../chapter-05-gui/Lists/README.md\
    ../chapter-05-gui/Navigation/README.md\
    ../chapter-05-gui/Layouts/README.md\
    ../chapter-05-gui/Localisation/README.md\
    ../chapter-05-gui/DataBinding/README.md\
    ../chapter-06-concurrency/README.md\
    ../chapter-06-concurrency/Concurrency/README.md\
    ../chapter-06-concurrency/GCD/README.md\
    ../chapter-06-concurrency/run-heros-api-webservice-locally/README.md\
    ../chapter-07-persistency/README.md\
    ../chapter-07-persistency/Persistency/README.md\
    ../chapter-08-location/README.md\
    ../chapter-08-location/Location/README.md\
    ../chapter-09-animation/README.md\
    ../chapter-09-animation/Animation/README.md\
    ../chapter-10-sensors/README.md\
    ../chapter-10-sensors/QR-Scanner/README.md\
    ../chapter-11-security/README.md\
    ../chapter-12-system/README.md\
    ../chapter-12-system/URLSchemes/README.md\
    ../chapter-12-system/Sharing/README.md\
\
    ../demo-apps-how-to-add-another-app.md\

