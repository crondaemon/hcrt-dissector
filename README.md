HCrt dissector
==============

This is a Wireshark dissector for the HCrt protocol. It is compiled as a plugin
and installed into current user plugin directory.

Compilation
-----------

Once cloned the repository, issue the following instructions:

    mkdir build
    cd build
    cmake ..
    ... solve any issues with dependencies ...
    make
    make install

Dissection
----------

The plugin runs both on Ethernet and UDP. For ethernet the protocol type is 0xf052,
while for UDP the port is 47000. The base ports can be changed in the HCrt
preference section.

__NOTE__: These numbers are subject to change since protocol has not got a IANA
assignment (yet).
