#!/bin/bash
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#

echo -e "\nWireshark Trunk Patcher v0.1\nby Dario Lombardo"

HOOK="packet-vrt.c"

DISSECTOR="packet-hcrt.c"

if [ "$1" == "" ]
then
    echo -e "\nUsage: $0 <dir>\n"
    echo -e "\tdir: the Wireshark source dir\n"
    exit 1
fi

WSTRUNK=$1

echo

# check that ws dir is good
echo -n "Tracking Wireshark source dir "
if [[ ! -d "$WSTRUNK/epan" || ! -d "$WSTRUNK/epan/dissectors" ]]
then
    echo -e "ERROR. Can't track dirs.\nPlease provide a Wireshark source tree\n"
    exit 2
fi
if [[ ! -f "$WSTRUNK/epan/CMakeLists.txt" || ! -f "$WSTRUNK/epan/dissectors/Makefile.common" ]]
then
    echo -e "ERROR. Can't track makefiles.\nPlease provide a Wireshark source tree\n"
    exit 2
fi
echo "[DONE]"

# check that hook is good
echo -n "Looking for hook ($HOOK) "
grep -q $HOOK $WSTRUNK/epan/CMakeLists.txt
if [ "$?" != "0" ]
then
    echo -e "ERROR. Can't find hook in epan/CMakeLists.txt\n"
    exit 2
fi
grep -q $HOOK $WSTRUNK/epan/dissectors/Makefile.common
if [ "$?" != "0" ]
then
    echo -e "ERROR. Can't fine hook in epan/dissectors/Makefile.common\n"
    exit 2
fi
echo "[DONE]"

# check that dissector isn't installed yet
echo -n "Looking for previous patches "
if [ -f "$WSTRUNK/epan/dissectors/$DISSECTOR" ]
then
    echo -e "ERROR. Dissector already found.\nCan't patch Wireshark\n"
    exit 3
fi
echo "[DONE]"

# Patch CMakeLists
echo -n "Patching CMakeLists.txt "
sed -i "s/$HOOK/$HOOK\n\tdissectors\/$DISSECTOR/g" $WSTRUNK/epan/CMakeLists.txt
if [ "$?" != "0" ]
then
    echo -e "ERROR. Can't patch CMakeLists.txt\n"
    exit 4
fi
echo "[DONE]"

# Patch Makefile.common
echo -n "Patching Makefile.common "
sed -i "s/$HOOK/$HOOK $DISSECTOR/g" $WSTRUNK/epan/dissectors/Makefile.common
if [ "$?" != "0" ]
then
    echo -e "ERROR. Can't patch Makefile.common\n"
    exit 4
fi
echo "[DONE]"

# Copy dissector
echo -n "Copying dissector "
cp $DISSECTOR $WSTRUNK/epan/dissectors
if [ "$?" != "0" ]
then
    echo -e "ERROR. Can't copy dissector\n"
    exit 5
fi
echo "[DONE]"

echo -e "\nPatching complete\n"
