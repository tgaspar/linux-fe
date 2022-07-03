#!/bin/bash
case $1 in

  slv | [Ss]lovene | [Ss]lovenian)
    echo "Pozdravljeni!"
    ;;

  eng | [Ee]nglish)
    echo "Hello!"
    ;;

  tlh | [Kk]lingon | [Tt]lhIngan)
    echo "nuqneH"
    ;;

  *)
    echo "Unsupported language code ($1). Must be one of the following: slv, eng, tlh"
    ;;
esac