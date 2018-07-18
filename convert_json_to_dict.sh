#!/usr/bin/env bash

INPUT=${1:-"./dict/english-vietnamese-dict.json"};
OUT_DIR=${2:-"out"};
TEMPLATE_DIR="template";

mkdir -p ${OUT_DIR};

time sed '1d;$d' ${INPUT} | head -n 300000 | awk '{
    split($0, a, "\":");
    gsub("\"", "", a[1]);
    gsub("\"", "", a[2]);
    gsub(",$", "", a[2]);
    gsub(/^@/, "", a[2]);
    gsub(/^ @/, "", a[2]);
    gsub(/^ @/, "", a[2]);
    gsub(/^  @/, "", a[2]);
    gsub(/^   @/, "", a[2]);
    gsub("@", "<br />", a[2]);
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
