#!/bin/sh

strings tmp/opmnini/Payload/Opera\ Mini.app/operamini.armv7
strings tmp/opmnini/Payload/Opera\ Mini.app/operamini.armv7 | grep @\"CLLocation
  # maybe no string/class Corelocation found, 
  #                    if binary is encrypted