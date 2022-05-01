import xml.etree.ElementTree as ET
import sys
import os
import subprocess
filepath=sys.argv[1]
#'/Users/somdoppio/Documents/GitHub/makro-mango/output.xml'
# filepath = "/Users/somdoppio/Documents/GitHub/scgh-retail/docker_log/output.xml"
tree = ET.parse(filepath)
root = tree.getroot()
count = 0
tc_pass = 0
tc_fail = 0
for d in root.findall("statistics"):
    for s in d:
        if s.tag == 'total':
            for x in s:
                tc_pass:int = int(x.attrib['pass'])
                tc_fail:int = int(x.attrib['fail'])

print(f'\n `TOTAL ` : {tc_pass+tc_fail} \n `PASSED` : {tc_pass} \n `FAILED` : {tc_fail}')

