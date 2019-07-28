#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

THEBURNINGSAVAGED=${THEBURNINGSAVAGED:-$BINDIR/theburningsavaged}
THEBURNINGSAVAGECLI=${THEBURNINGSAVAGECLI:-$BINDIR/theburningsavage-cli}
THEBURNINGSAVAGETX=${THEBURNINGSAVAGETX:-$BINDIR/theburningsavage-tx}
THEBURNINGSAVAGEQT=${THEBURNINGSAVAGEQT:-$BINDIR/qt/theburningsavage-qt}

[ ! -x $THEBURNINGSAVAGED ] && echo "$THEBURNINGSAVAGED not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
TBSVER=($($THEBURNINGSAVAGECLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for theburningsavaged if --version-string is not set,
# but has different outcomes for theburningsavage-qt and theburningsavage-cli.
echo "[COPYRIGHT]" > footer.h2m
$THEBURNINGSAVAGED --version | sed -n '1!p' >> footer.h2m

for cmd in $THEBURNINGSAVAGED $THEBURNINGSAVAGECLI $THEBURNINGSAVAGETX $THEBURNINGSAVAGEQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${TBSVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${TBSVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
