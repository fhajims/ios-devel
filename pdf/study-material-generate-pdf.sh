#!/bin/zsh

# convert markdown to one single PDF

OUT="study-material"


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
  cat  pandoc-data-dir/metadata-study-material.template.txt | envsubst > pandoc-data-dir/metadata-study-material.md
}


# Note: see config.yaml for further (default) configuration
# Note: see metadata.md (possibly, generated from metadata.template.txt) for Title, Subtitle, author, ....

# do not modify anything below this line


echo "We convert the *.md to a PDF file with pandoc..."
pandoc\
  --data-dir=pandoc-data-dir\
  --defaults=pandoc-data-dir/config-study-material.yaml\
  --listings\
  --include-in-header pandoc-data-dir/listings-setup.tex \
  --resource-path=pandoc-data-dir:../\
  --toc\
  --lua-filter=pandoc-data-dir/fix-links-multiple-files.lua\
  -f markdown\
  -t pdf\
  -o "${OUT}.pdf"\
  pandoc-data-dir/metadata-study-material.md\
    ../study-material--overview.md\
    ../study-material--part-A-Swift.md\
    ../study-material--part-B-Tools.md\
    ../study-material--part-C-Apps.md\
    ../study-material--part-D-APIs.md\
    ../study-material--part-E-iOS.md\
    ../study-material--part-F-Security.md\
    ../study-material--part-X-Possible-exam-questions.md\
    ../study-material--part-Y-Fun-facts.md\
    ../study-material--part-Z-Links.md\
