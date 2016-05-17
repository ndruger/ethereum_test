echo source=\"`cat $1 | perl -pe 's/\n/\\\\\\\\n/'`\"
