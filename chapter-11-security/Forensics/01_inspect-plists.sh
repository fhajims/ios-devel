#!/bin/sh
fn="History.plist"

mkdir -p tmp
echo "Extracting binary to xml"
plutil -convert xml1 ${fn} -o tmp/${fn}

cat tmp/${fn}
# ...
# <?xml version="1.0" encoding="UTF-8"?>
# <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
# <plist version="1.0">
# <dict>
#   <key>WebHistoryDates</key>
#   <array>
#     <dict>
#       <key></key>
#       <string>http://www.apple.com/at/</string>
# ...


echo "optionally modify the xml"

cat tmp/History.plist|sed -E 's/WebHistory/WEBHIST/g' > tmp/changed_${fn}

echo "save back to binary"

plutil -convert binary1 tmp/changed_${fn} -o changed_${fn}
plutil -convert xml1 changed_${fn} -o tmp/re-extracted_changed_${fn}

echo "show diffs"
diff "tmp/re-extracted_changed_${fn}" "tmp/${fn}"

# 5c5
# <   <key>WEBHISTDates</key>
# ---
# >   <key>WebHistoryDates</key>
# 68c68
# <   <key>WEBHISTFileVersion</key>
# ---
# >   <key>WebHistoryFileVersion</key>