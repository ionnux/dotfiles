#!/usr/bin/env bash
# resize {up,down,east,west} delta

delta=${2:-"30"}

case $1 in
  right)  dimension=w; sign=+ ;;
  left)   dimension=w; sign=- ;;
  up)     dimension=h; sign=- ;;
  down)   dimension=h; sign=+ ;;
  *) echo "Usage: resize {up,down,left,right} [delta]" && exit 1 ;;
esac

x=0; y=0;
case $dimension in
  w) x=$sign$delta;  direction=right;  fallback_direction=left   ;;
  h) y=$sign$delta;  direction=top;    fallback_direction=bottom ;;
esac

bspc node -z "$direction" "$x" "$y" || bspc node -z "$fallback_direction" "$x" "$y";
