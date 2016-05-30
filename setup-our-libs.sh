#!/bin/bash

git clone --recursive https://github.com/jiveui/lime ../lime
haxelib dev lime ../lime

git clone https://github.com/jiveui/openfl ../openfl
haxelib dev openfl ../openfl

git clone https://github.com/jiveui/jive-chart ../jive-chart
haxelib dev jive-chart ../jive-chart/src

git clone https://github.com/jiveui/jive-nativetext ../jive-nativetext
haxelib dev jive-nativetext ../jive-nativetext

git clone https://github.com/jiveui/haxe-rest-client ../haxe-rest-client
haxelib dev rest-client ../haxe-rest-client

git clone https://github.com/jiveui/hml-xsd-gen ../hml-xsd-gen
haxelib dev hml-xsd-gen ../hml-xsd-gen

git clone https://github.com/jiveui/hml ../hml
haxelib dev hml ../hml

git clone https://github.com/jiveui/bindx ../bindx
haxelib dev bindx ../bindx/src

git clone https://github.com/jiveui/getimagext ../getimagext
git clone https://github.com/jiveui/nativetext ../nativetext
git clone https://github.com/jiveui/extensionkit ../extensionkit
git clone https://github.com/jiveui/extension-qrscan ../extension-qrscan

haxelib install format
haxelib install svg
haxelib install unifill
haxelib install rox-i18n
haxelib install thx.core

haxelib dev lime ../lime
haxelib dev openfl ../openfl
haxelib dev jive ../jive/src
haxelib dev hml ../hml