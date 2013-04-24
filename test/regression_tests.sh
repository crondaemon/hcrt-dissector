#!/bin/bash
#
# List your tests here.
#
# Example: ./core_test pcap/file_with_just_one_packet field_to_test expected_value
#

echo -n "Running tests"

./core_test pcap/req_nop_1.pcap hcrt.tag 0x00
./core_test pcap/req_nop_1.pcap hcrt.type 0
./core_test pcap/req_nop_1.pcap hcrt.am 0
./core_test pcap/req_nop_1.pcap hcrt.do 1
./core_test pcap/req_nop_1.pcap hcrt.first_dword_enable 0x0f
./core_test pcap/req_nop_1.pcap hcrt.last_dword_enable 0x0f
./core_test pcap/req_nop_1.pcap hcrt.adl 2
./core_test pcap/req_nop_1.pcap hcrt.last 1

./core_test pcap/req_read_1.pcap hcrt.tag 0x02
./core_test pcap/req_read_1.pcap hcrt.type 2
./core_test pcap/req_read_1.pcap hcrt.am 0
./core_test pcap/req_read_1.pcap hcrt.do 1
./core_test pcap/req_read_1.pcap hcrt.first_dword_enable 0x0f
./core_test pcap/req_read_1.pcap hcrt.last_dword_enable 0x0f
./core_test pcap/req_read_1.pcap hcrt.adl 1
./core_test pcap/req_read_1.pcap hcrt.last 1

./core_test pcap/req_write_1.pcap hcrt.tag 0x00
./core_test pcap/req_write_1.pcap hcrt.type 1
./core_test pcap/req_write_1.pcap hcrt.am 0
./core_test pcap/req_write_1.pcap hcrt.do 1
./core_test pcap/req_write_1.pcap hcrt.first_dword_enable 0x0f
./core_test pcap/req_write_1.pcap hcrt.last_dword_enable 0x0f
./core_test pcap/req_write_1.pcap hcrt.adl 1
./core_test pcap/req_write_1.pcap hcrt.last 1

./core_test pcap/req_write_2.pcap hcrt.tag 0x00
./core_test pcap/req_write_2.pcap hcrt.type 1
./core_test pcap/req_write_2.pcap hcrt.am 0
./core_test pcap/req_write_2.pcap hcrt.do 1
./core_test pcap/req_write_2.pcap hcrt.first_dword_enable 0x0f
./core_test pcap/req_write_2.pcap hcrt.last_dword_enable 0x0f
./core_test pcap/req_write_2.pcap hcrt.adl 1
./core_test pcap/req_write_2.pcap hcrt.last 0

echo -e "finished"
