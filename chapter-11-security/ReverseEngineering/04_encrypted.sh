#!/bin/sh

otool -l tmp/opmnini/Payload/Opera\ Mini.app/operamini.armv7 | grep "ENC" -B1 -A4
  # Load command 12
  #        cmd LC_ENCRYPTION_INFO
  #    cmdsize 20
  #   cryptoff 16384
  #  cryptsize 7864320
  #    cryptid 1
