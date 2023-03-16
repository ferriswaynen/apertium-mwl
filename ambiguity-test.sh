CORPUS=../ling073-mwl-corpus/mwl.wikipedia.2023-01-31.txt 
MORPH=mwl.automorf.bin
RLX=mwl.rlx.bin # you might need to remove ".bin"
TOKENS=`apertium-destxt ${CORPUS} | lt-proc ${MORPH} | apertium-retxt | sed 's/$\W*\^/$\n^/g' | wc -l`
ANALYSES=`apertium-destxt ${CORPUS} | lt-proc ${MORPH} | apertium-retxt | sed 's/$\W*\^/$\n^/g' | cut -f2- -d'/' | sed 's/\//\n/g' | wc -l`
DISAMB=`apertium-destxt ${CORPUS} | lt-proc ${MORPH} | cg-proc ${RLX} | apertium-retxt | sed 's/$\W*\^/$\n^/g' | cut -f2- -d'/' | sed 's/\//\n/g' | wc -l`
AMBIGPRE=`calc $ANALYSES/$TOKENS`
AMBIGPOST=`calc $DISAMB/$TOKENS`
echo "Ambiguity before disambiguation: ${AMBIGPRE}"
echo "Ambiguity after disambiguation: ${AMBIGPOST}"