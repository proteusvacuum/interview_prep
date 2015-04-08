#! /usr/bin/env python
import re
import sys
from collections import Counter


def extract_ips(inpt):
    """Extract anything that looks like an ip address from the input"""

    dotted_decimal = r'(?P<dotted_decimal>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})'
    dotted_hexadecimal = (r'(?P<dotted_hex>0x[0-9a-e|A-E]{1,3}\.'
                          r'0x[0-9a-eA-E]{1,3}\.0x[0-9a-e|A-E]{1,3}\.'
                          r'0x[0-9a-eA-E]{1,3})')
    dotted_octal = r'(?P<dotted_octal>\d{4}\.\d{4}\.\d{4}\.\d{4})'
    dotted_binary = r'(?P<dotted_bin>[0-1]{8}\.[0-1]{8}\.[0-1]{8}\.[0-1]{8})'
    binary = r'(?P<bin>[0-1]{30,32})'
    octal = r'(?P<octal>0[0-7]{11})'
    hexadecimal = r'(?P<hex>0x[0-9a-e|A-E]{8})'
    decimal = r'(?P<decimal>\d{10}^\.)'
    return re.finditer(dotted_decimal + '|' + dotted_hexadecimal + '|' +
                       dotted_octal + '|' + dotted_binary + '|' + binary + '|'
                       + octal + '|' + hexadecimal + '|' + decimal, inpt)


def dotted_to_decimal_dotted(address, radix):
    dotted = map(lambda x: str(int(x, radix)), address.split('.'))
    return '.'.join(dotted)


def undotted_to_dotted(address, radix):
    dotted = []
    for x in range(0, 4):
        dotted.insert(0, str((int(address, radix) >> 8 * x) & 0xff))
    return '.'.join(dotted)


def valid_addresses(addresses):
    """Takes a list of addresses, returns only the valid ones"""
    valid_addresses = []
    for address in addresses:
        address_bits = address.split('.')
        if (int(address_bits[0]) >= 1 and int(address_bits[0]) <= 255 and
           int(address_bits[1]) <= 255 and int(address_bits[2]) <= 255 and
           int(address_bits[3]) <= 254):
            valid_addresses.append(address)
    return valid_addresses


def most_common(addresses):
    return Counter(addresses).most_common(1)


test_cases = open(sys.argv[1], 'r')
all_addresses = []
for test in test_cases:

    for address in extract_ips(test):
        # convert everything to dotted decimal and store
        dotteds = (('dotted_hex', 16), ('dotted_bin', 2), ('dotted_octal', 8))
        undotteds = (('bin', 2), ('octal', 8), ('hex', 16), ('decimal', 10))

        if address.group('dotted_decimal'):
            all_addresses.append(address.group('dotted_decimal'))

        for dotted in dotteds:
            dotted_address = address.group(dotted[0])
            radix = dotted[1]
            if dotted_address:
                all_addresses.append(
                    dotted_to_decimal_dotted(dotted_address, radix))

        for undotted in undotteds:
            undotted_address = address.group(undotted[0])
            radix = undotted[1]
            if undotted_address:
                all_addresses.append(
                    undotted_to_dotted(undotted_address, radix))

        # valid_address(address)
        # all_addresses.append(address)
test_cases.close()
print most_common(valid_addresses(all_addresses))[0][0]
