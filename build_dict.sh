#!/usr/bin/env bash

INPUT=${1:-"./dict/common-english-viet-words.txt"};
OUT_DIR=${2:-"out"};
TEMPLATE_DIR="template";

mkdir -p ${OUT_DIR};

time sed '1d;$d' ${INPUT} | awk '{
    split($0, a, "\t");
    gsub("@"a[1], "", a[2]);
    gsub(/\\n\*/, "<br/>", a[2]);
    gsub(/\\n-/, "<br/>", a[2]);
    gsub(/\\n/, "<br/>", a[2]);
    print "<p><idx:entry><idx:orth>";
    print a[1];
    print "</idx:orth>&mdash;";
    print a[2];
    print "</idx:entry></p>";
}' > ${OUT_DIR}/entries.html;

# Need to reserve BOM (Byte Order Mark) for dic.html and doc.opf
(echo -n -e '\xEF\xBB\xBF'; cat ${TEMPLATE_DIR}/header.html ${OUT_DIR}/entries.html ${TEMPLATE_DIR}/footer.html) > ${OUT_DIR}/dic.html;
(echo -n -e '\xEF\xBB\xBF'; cat ${TEMPLATE_DIR}/doc.opf) >  ${OUT_DIR}/doc.opf;
cp ${TEMPLATE_DIR}/dic.png ${OUT_DIR}/;

time kindlegen  -verbose ${OUT_DIR}/doc.opf;
